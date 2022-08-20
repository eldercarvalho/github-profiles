import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:github_profiles/core/core.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userLogin),
      ),
      body: BlocBuilder<ReposCubit, ReposState>(
        bloc: _reposCubit,
        builder: (context, state) {
          if (state is SuccessState) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.repos.length,
              itemBuilder: (context, index) {
                final repo = state.repos[index];

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        repo.name,
                        style: theme.textTheme.headline6
                            ?.copyWith(color: Colors.blue),
                      ),
                      if (repo.hasDescription) ...[
                        const SizedBox(height: 12),
                        Text(
                          repo.description!,
                          style:
                              theme.textTheme.bodyText1?.copyWith(height: 1.6),
                        )
                      ],
                      if (repo.hasHomepage) ...[
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.link, size: 18),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                repo.homepage!,
                                style: theme.textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          if (repo.hasLanguage) ...[
                            Text(
                              repo.language!,
                              style: theme.textTheme.subtitle2,
                            ),
                            const SizedBox(width: 20),
                          ],
                          const Icon(Icons.fork_left_outlined, size: 18),
                          Text(
                            '${repo.forksCount}',
                            style: theme.textTheme.subtitle2,
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.star, size: 18),
                          Text(
                            '${repo.stargazersCount}',
                            style: theme.textTheme.subtitle2,
                          )
                        ],
                      ),
                    ],
                  ),
                );
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
