import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ioc_app/locator.dart';
import 'package:ioc_app/pages/home_page.dart';
import 'package:ioc_app/providers/theme_provider.dart';
import 'package:ioc_app/services/shared_preferences_service.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = locator<SharedPreferencesService>();
    final appTheme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: prefs.isFirstLaunch ? ThemeMode.system : appTheme,
      themeAnimationDuration: Duration.zero,
      // Theme animationDuration is set to zero [Issue Link](https://github.com/flutter/flutter/issues/105883)
      home: HomePage(),
    );
  }
}
