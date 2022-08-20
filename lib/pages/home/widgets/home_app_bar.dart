import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/pages/home/cubit/home_cubit.dart';

import 'home_search_field.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  static final _appBar = AppBar();

  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(HomeAppBar._appBar.preferredSize.height);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final _focusNode = FocusNode();
  final _debounce = Debounce(const Duration(milliseconds: 400));
  bool _isSearch = false;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return AppBar(
      elevation: 0,
      title: _isSearch
          ? HomeSearchField(
              focusNode: _focusNode,
              onChanged: (search) => _debounce(
                () => _onSearchChanged(search, homeCubit),
              ),
            )
          : Row(
              children: [
                Image.asset('assets/images/github-logo.png'),
                const SizedBox(width: 16),
                const Text('Profiles'),
              ],
            ), //const Text('GitHub Profiles'),
      actions: [
        IconButton(
          onPressed: () => _showSearch(homeCubit),
          icon: _isSearch ? const Icon(Icons.close) : const Icon(Icons.search),
        ),
      ],
    );
  }

  void _showSearch(HomeCubit homeCubit) {
    setState(() => _isSearch = !_isSearch);

    if (_isSearch) {
      _focusNode.requestFocus();
      return;
    }

    homeCubit.fetchUsers(cached: true);
    _focusNode.unfocus();
  }

  void _onSearchChanged(String value, HomeCubit homeCubit) {
    if (value.isNotEmpty) {
      homeCubit.fetchUserInfo(value);
      return;
    }

    homeCubit.fetchUsers(cached: true);
  }
}
