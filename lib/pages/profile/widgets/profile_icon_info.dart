import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileIconInfo extends StatelessWidget {
  const ProfileIconInfo({
    Key? key,
    required this.iconData,
    this.text,
    required this.visible,
  }) : super(key: key);

  final IconData iconData;
  final String? text;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          Text(text ?? '', style: theme.textTheme.bodyText2),
        ]),
      ),
    );
  }
}
