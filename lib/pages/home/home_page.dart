import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:github_profiles/core/debounce.dart';
import 'package:github_profiles/core/injections.dart';

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
  final _controller = TextEditingController();
  bool _isSearch = false;

  @override
  void initState() {
    _homeCubit.fetchUsers();

    _controller.addListener(() {
      _debounce(() => _onSearchChanged(_controller.text));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _isSearch
            ? TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              )
            : Row(
                children: const [
                  Icon(Icons.report),
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
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: _homeCubit,
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
                );
              },
            );
          }

          if (state is HomeSearchSuccessState) {
            return Text(state.user.login);
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

    _focusNode.unfocus();
    _homeCubit.fetchUsers();
  }

  void _onSearchChanged(String value) {
    if (value.isNotEmpty) {
      _homeCubit.fetchUserInfo(value);
      return;
    }

    _homeCubit.fetchUsers();
  }
}
