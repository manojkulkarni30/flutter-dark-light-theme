import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData themeData() => Theme.of(this);

  TextTheme textTheme() => Theme.of(this).textTheme;
}
