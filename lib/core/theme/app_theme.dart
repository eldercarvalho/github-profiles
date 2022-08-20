import 'package:flutter/material.dart';

import 'colors.dart';

final appTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  textTheme: ThemeData.dark().textTheme.copyWith(
        bodyText1: const TextStyle(
          fontSize: 16,
          fontFamily: "NunitoSans",
          color: bodyTextColor,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: const TextStyle(
          fontSize: 14,
          fontFamily: "NunitoSans",
          color: bodyTextColor,
          fontWeight: FontWeight.w400,
        ),
      ),
  appBarTheme: const AppBarTheme(
    backgroundColor: onBackgroundColor,
    elevation: 0,
  ),
  scaffoldBackgroundColor: backgroundColor,
);
