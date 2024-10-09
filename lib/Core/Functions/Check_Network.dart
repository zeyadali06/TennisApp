import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConn() async {
  bool status = true;
  try {
    final Connectivity conn = Connectivity();
    await conn.checkConnectivity();
    final StreamSubscription<List<ConnectivityResult>> connectivitySubscription = conn.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.last == ConnectivityResult.none) {
        status = false;
      }
    });

    await Future.delayed(const Duration(seconds: 1));
    await connectivitySubscription.cancel();
  } catch (_) {
    status = false;
  }

  return status;
}
