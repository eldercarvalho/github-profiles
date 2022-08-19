import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profiles/core/core.dart';

import 'cubit/cubit.dart';

class ProfilePage extends StatefulWidget {
  final String userLogin;

  const ProfilePage({
    Key? key,
    @PathParam('userLogin') required this.userLogin,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileCubit = getIt<ProfileCubit>();

  @override
  void initState() {
    _profileCubit.fetchUserInfo(widget.userLogin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userLogin),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            final user = state.user;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(user.avatarUrl),
                  const SizedBox(height: 20),
                  if (user.name != null)
                    Text(
                      user.name!,
                      style: theme.textTheme.headline5,
                    ),
                  const SizedBox(height: 20),
                  if (user.hasBio) Text(user.bio!),
                  if (user.hasBlog) Text(user.blog!),
                  if (user.hasEmail) Text(user.email!),
                  if (user.hasFollowers) Text('${user.followers}'),
                  if (user.hasFollowing) Text('${user.following}'),
                  if (user.hasLocation) Text(user.location!),
                  if (user.hasCreatedAt) Text(user.readableCreatedAt!),
                  if (user.hasTwitterUsername) Text(user.twitterUsername!),
                  if (user.hasPublicRepos) Text('${user.publicRepos}'),
                ],
              ),
            );
          }

          if (state is ProfileFailureState) {
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
