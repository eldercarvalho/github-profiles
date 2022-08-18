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
  final HomeCubit _homeCubit = getIt<HomeCubit>();
  final FocusNode _focusNode = FocusNode();
  final Debounce _debounce = Debounce(const Duration(milliseconds: 400));
  bool _isSearch = false;

  @override
  void initState() {
    _homeCubit.fetchUsers();
    super.initState();
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
                ),
                onChanged: _onSearchChanged,
              )
            : Row(
                children: const [
                  Icon(Icons.report),
                  Text('GitHub Profiles'),
                ],
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => _isSearch = !_isSearch);
              if (_isSearch) {
                _focusNode.requestFocus();
              } else {
                _focusNode.unfocus();
              }
            },
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

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _onSearchChanged(String value) {
    _debounce(() => print(value));
  }
}
