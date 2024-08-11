import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ioc_app/locator.dart';
import 'package:ioc_app/pages/next_page.dart';
import 'package:ioc_app/providers/theme_provider.dart';
import 'package:ioc_app/services/shared_preferences_service.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final prefs = locator<SharedPreferencesService>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = false;
    bool invalidateProvider = false;
    if (prefs.isFirstLaunch) {
      prefs.isFirstLaunch = false;
      prefs.isDarkMode =
          isDarkMode = Theme.of(context).brightness == Brightness.dark;
      invalidateProvider = true;
    } else {
      isDarkMode = ref.read(themeProvider) == ThemeMode.dark;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter App'),
        actions: [
          IconButton(
              onPressed: () {
                if (invalidateProvider) ref.invalidate(themeProvider);
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to flutter',
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NextPage(),
                      ));
                },
                child: const Text('Next Page'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
