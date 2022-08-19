import 'package:flutter/material.dart';

import 'package:github_profiles/core/core.dart';

class EmptyState extends StatelessWidget {
  final Failure failure;

  const EmptyState({
    Key? key,
    required this.failure,
  }) : super(key: key);

  String get _imagePath {
    if (failure is ServerFailure) {
      return 'no-results.png';
    }

    return 'error.png';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/$_imagePath'),
          const SizedBox(height: 8),
          Text(
            _getTitleByFailure(failure: failure),
            style: theme.textTheme.headline6,
          ),
          const SizedBox(height: 8),
          Text(
            _getDefaultMessageByFailure(failure: failure),
            style: theme.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  String _getTitleByFailure({
    required Failure failure,
  }) {
    if (failure is ServerFailure && failure.isNotFound) {
      return "No users found";
    }

    if (failure is NoConnectionFailure) {
      return "No Connection";
    }

    return "Oops! something unexpected happened";
  }

  String _getDefaultMessageByFailure({
    required Failure failure,
  }) {
    if (failure is ServerFailure && failure.isNotFound) {
      return "No users found for your search term";
    }

    if (failure is ServerFailure) {
      return "An error ocurred on the server, please try again later";
    }

    if (failure is NoConnectionFailure) {
      return "Check your internet connection and try again";
    }

    return "Your request could not be processed, please try again later";
  }
}
