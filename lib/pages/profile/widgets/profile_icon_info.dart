import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:github_profiles/core/core.dart';

class ProfileIconInfo extends StatelessWidget {
  const ProfileIconInfo(
      {Key? key,
      required this.iconData,
      this.text,
      required this.visible,
      this.linked = false})
      : super(key: key);

  final IconData iconData;
  final String? text;
  final bool visible;
  final bool linked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = linked
        ? theme.textTheme.bodyText2?.copyWith(color: linkColor)
        : theme.textTheme.bodyText2;

    return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(children: [
          FaIcon(
            iconData,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: linked
                  ? () => lauchUrl(
                        context: context,
                        url: text ?? '',
                        protocol: LauchProtocol.http,
                      )
                  : null,
              child: Text(
                text ?? '',
                style: textStyle,
                overflow: TextOverflow.fade,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
