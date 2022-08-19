import 'package:flutter/material.dart';

class HomeSearchField extends StatelessWidget {
  final FocusNode focusNode;
  final Function(String value) onChanged;

  const HomeSearchField({
    Key? key,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }
}
