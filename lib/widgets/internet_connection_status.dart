import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ioc_app/extensions/utility.dart';
import 'package:ioc_app/providers/internet_connection_provider.dart';

class InternetConnectionStatus extends ConsumerWidget {
  const InternetConnectionStatus({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetConnectionStatus =
        ref.watch(internetConnectionStatusProvider);

    return internetConnectionStatus.when<Widget>(
      data: (data) {
        if (data) {
          return child;
        } else {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.signal_wifi_connected_no_internet_4,
                  size: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'No internet connection',
                  style: context.textTheme().titleLarge,
                ),
              ],
            )),
          );
        }
      },
      error: (error, stackTrace) {
        return const Scaffold(
          body: Center(
              child: Text(
                  'Error occured while fetching internet connection status')),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
