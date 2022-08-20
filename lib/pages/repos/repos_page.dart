import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/repo_entity.dart';
import 'package:github_profiles/pages/repos/widgets/repo_card.dart';

import 'cubit/cubit.dart';

class ReposPage extends StatefulWidget {
  final String userLogin;

  const ReposPage({
    Key? key,
    @PathParam('userLogin') required this.userLogin,
  }) : super(key: key);

  @override
  State<ReposPage> createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  final _reposCubit = getIt<ReposCubit>();

  @override
  void initState() {
    _reposCubit.fetchRepos(widget.userLogin);
    super.initState();
  }

  @override
  void dispose() {
    _reposCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.userLogin}'s Repos"),
      ),
      body: BlocBuilder<ReposCubit, ReposState>(
        bloc: _reposCubit,
        builder: (context, state) {
          if (state is SuccessState) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.repos.length,
              itemBuilder: (context, index) {
                return RepoCard(repo: state.repos[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            );
          }

          if (state is FailureState) {
            return EmptyState(
              failure: state.failure,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


