import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';

import 'package:github_profiles/core/debounce.dart';
import 'package:github_profiles/core/injections.dart';
import 'package:github_profiles/entities/user_entity.dart';

import 'cubit/cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeCubit = getIt<HomeCubit>();
  final _focusNode = FocusNode();
  final _debounce = Debounce(const Duration(milliseconds: 400));
  List<AppContact>? _contacts;
  bool _isSearch = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _homeCubit.fetchContacts();
    });
    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _isSearch
            ? TextField(
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) => _debounce(() => _onSearchChanged(value)),
              )
            : Row(
                children: const [
                  // Icon(Icons.report),
                  Text('GitHub Profiles'),
                ],
              ),
        actions: [
          IconButton(
            onPressed: _showSearch,
            icon:
                _isSearch ? const Icon(Icons.close) : const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: _homeCubit,
        listener: (context, state) {
          if (state is HomeContactsState) {
            setState(() => _contacts = state.contacts);
            // _homeCubit.fetchUsers();
          }
        },
        listenWhen: (oldState, state) => state is HomeContactsState,
        buildWhen: (oldState, state) => state is! HomeContactsState,
        builder: (context, state) {
          if (state is HomeSuccessState) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    child: Image.network(user.avatarUrl),
                  ),
                  title: Text(state.users[index].login),
                  trailing: _checkIfUserIsInContacts(user)
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            );
          }

          if (state is HomeSearchSuccessState) {
            final user = state.user;
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: Image.network(user.avatarUrl),
              ),
              title: Text(user.login),
              trailing: _checkIfUserIsInContacts(user)
                  ? const Icon(Icons.check)
                  : null,
            );
          }

          if (state is HomeFailureState) {
            return const Center(
              child: Text('Deu pau'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _showSearch() {
    setState(() => _isSearch = !_isSearch);

    if (_isSearch) {
      _focusNode.requestFocus();
      return;
    }

    _homeCubit.fetchUsers(cached: true);
    _focusNode.unfocus();
  }

  void _onSearchChanged(String value) {
    if (value.isNotEmpty) {
      _homeCubit.fetchUserInfo(value);
      return;
    }

    _homeCubit.fetchUsers();
  }

  bool _checkIfUserIsInContacts(UserEntity user) {
    return _contacts?.any((contact) => contact.displayName == user.login) ??
        false;
  }
}
