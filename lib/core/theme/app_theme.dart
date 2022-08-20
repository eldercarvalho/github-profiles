import 'package:flutter/material.dart';

import 'colors.dart';

final appTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: onBackgroundColor,
    elevation: 0,
  ),
  scaffoldBackgroundColor: backgroundColor,
);
