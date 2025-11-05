import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChecker with ChangeNotifier {
  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;

  late StreamSubscription _subscription;

  NetworkChecker() {
    _subscription = Connectivity().onConnectivityChanged.listen((_) async {
      bool connected = await InternetConnectionChecker().hasConnection;
      if (connected != _hasConnection) {
        _hasConnection = connected;
        notifyListeners();
      }
    });

    // 初始检测
    _initCheck();
  }

  Future<void> _initCheck() async {
    _hasConnection = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
