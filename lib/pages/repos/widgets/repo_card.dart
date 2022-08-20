import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/repo_entity.dart';

class RepoCard extends StatelessWidget {
  const RepoCard({
    Key? key,
    required this.repo,
  }) : super(key: key);

  final RepoEntity repo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: onBackgroundColor,
        border: Border.all(
          color: borderColor,
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
            style: theme.textTheme.headline6?.copyWith(
              color: theme.colorScheme.primary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (repo.hasDescription) ...[
            const SizedBox(height: 12),
            Text(
              repo.description!,
              style: theme.textTheme.bodyText2?.copyWith(height: 1.6),
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
                  child: GestureDetector(
                    onTap: () => lauchUrl(
                      context: context,
                      url: repo.homepage!,
                      protocol: LauchProtocol.http,
                    ),
                    child: Text(
                      repo.homepage!,
                      style: theme.textTheme.bodyText2?.copyWith(
                        color: linkColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              if (repo.hasLanguage) ...[
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: techColors[repo.language] != null
                        ? Color(techColors[repo.language!]!)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  repo.language!,
                  style: theme.textTheme.bodyText2,
                ),
                const SizedBox(width: 20),
              ],
              FaIcon(
                FontAwesomeIcons.codeFork,
                size: 16,
                color: theme.textTheme.bodyText2?.color,
              ),
              const SizedBox(width: 8),
              Text(
                '${repo.forksCount}',
                style: theme.textTheme.bodyText2,
              ),
              const SizedBox(width: 20),
              FaIcon(
                FontAwesomeIcons.star,
                size: 16,
                color: theme.textTheme.bodyText2?.color,
              ),
              const SizedBox(width: 8),
              Text(
                '${repo.stargazersCount}',
                style: theme.textTheme.bodyText2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
