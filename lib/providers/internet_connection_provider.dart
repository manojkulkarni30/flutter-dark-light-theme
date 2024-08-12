import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionStatusNotifier extends AsyncNotifier<bool> {
  late InternetConnection _internetConnection;

  InternetConnectionStatusNotifier() {
    _internetConnection = InternetConnection();
  }

  @override
  FutureOr<bool> build() async {
    final listener = _internetConnection.onStatusChange.listen(
      (InternetStatus status) {
        switch (status) {
          case InternetStatus.connected:
            state = const AsyncValue.data(true);
            break;
          case InternetStatus.disconnected:
            state = const AsyncValue.data(false);
            break;
        }
      },
    );

    ref.onDispose(
      () {
        listener.cancel();
        print('[InternetConnectionNotifier] disposed');
      },
    );
    return await _internetConnection.hasInternetAccess;
  }
}

final internetConnectionStatusProvider =
    AsyncNotifierProvider<InternetConnectionStatusNotifier, bool>(
        InternetConnectionStatusNotifier.new);
