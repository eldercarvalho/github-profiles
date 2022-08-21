import 'package:flutter/material.dart';

import 'package:github_profiles/core/core.dart';

class EmptyState extends StatelessWidget {
  final Failure? failure;
  final String? imagePath;
  final String? title;
  final String? description;

  const EmptyState({
    Key? key,
    this.failure,
    this.imagePath,
    this.title,
    this.description,
  }) : super(key: key);

  String get _imagePath {
    if (failure != null) {
      if (failure is ServerFailure) {
        return 'no-results.png';
      }

      if (failure is NoConnectionFailure) {
        return 'no-connection.png';
      }

      return 'error.png';
    }

    if (imagePath != null) {
      return imagePath!;
    }

    return 'error.png';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 256),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/$_imagePath'),
            const SizedBox(height: 8),
            Text(
              _getTitle(),
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: 8),
            Text(
              _getDefaultDescription(),
              style: theme.textTheme.bodyText1?.copyWith(height: 1.6),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    if (failure != null) {
      if (failure is ServerFailure && (failure as ServerFailure).isNotFound) {
        return "No users found";
      }

      if (failure is NoConnectionFailure) {
        return "No Connection";
      }

      return "Oops! something unexpected happened";
    }

    if (title != null) {
      return title!;
    }

    return "Oops! something unexpected happened";
  }

  String _getDefaultDescription() {
    if (failure != null) {
      if (failure is ServerFailure && (failure as ServerFailure).isNotFound) {
        return "No users found for the search term";
      }

      if (failure is ServerFailure) {
        return "An error ocurred on the server, please try again later";
      }

      if (failure is NoConnectionFailure) {
        return "Check your internet connection and try again";
      }

      return "Your request could not be processed, please try again later";
    }

    if (description != null) {
      return description!;
    }

    return "Your request could not be processed, please try again later";
  }
}
