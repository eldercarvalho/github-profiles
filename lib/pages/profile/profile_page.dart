import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/user_entity.dart';

import 'cubit/cubit.dart';
import 'widgets/widgets.dart';

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
  void dispose() {
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userLogin),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            final user = state.user;
            return buildContent(user, theme, router);
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

  Widget buildContent(
    UserEntity user,
    ThemeData theme,
    StackRouter router,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileAvatar(user: user),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (user.hasName)
                  Text(
                    user.name!,
                    style: theme.textTheme.headline5,
                  ),
                Text(
                  widget.userLogin,
                  style: theme.textTheme.headline6
                      ?.copyWith(color: Colors.white.withOpacity(0.6)),
                ),
                if (user.hasBio) ...[
                  const SizedBox(height: 16),
                  Text(
                    user.bio!,
                    style: theme.textTheme.bodyText2?.copyWith(height: 1.6),
                  )
                ],
                const SizedBox(height: 16),
                ProfileIconInfo(
                  visible: user.hasBlog,
                  iconData: Icons.link,
                  text: user.blog,
                  linked: true,
                ),
                ProfileIconInfo(
                  visible: user.hasCompany,
                  iconData: Icons.corporate_fare,
                  text: user.company,
                ),
                ProfileIconInfo(
                  visible: user.hasLocation,
                  iconData: Icons.location_on_outlined,
                  text: user.location,
                ),
                ProfileIconInfo(
                  visible: user.hasEmail,
                  iconData: Icons.email,
                  text: user.email,
                ),
                ProfileIconInfo(
                  visible: user.hasTwitterUsername,
                  iconData: FontAwesomeIcons.twitter,
                  text: user.twitterUsername,
                ),
                ProfileIconInfo(
                  visible: user.hasFollowers,
                  iconData: Icons.group_outlined,
                  text:
                      '${user.followers} followers - ${user.following} following',
                ),
                ProfileIconInfo(
                  visible: user.hasPublicRepos,
                  iconData: Icons.book_outlined,
                  text: '${user.publicRepos} public repositories',
                ),
                ProfileIconInfo(
                  visible: user.hasCreatedAt,
                  iconData: Icons.cake_outlined,
                  text: 'User since ${user.readableCreatedAt}',
                ),
                const SizedBox(height: 16),
                RawMaterialButton(
                  fillColor: onBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        width: 1,
                        color: borderColor,
                        style: BorderStyle.solid,
                      )),
                  onPressed: () =>
                      router.pushNamed('/repos/${widget.userLogin}'),
                  child: const Text('Repositories'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
