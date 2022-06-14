import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService extends ChangeNotifier {
  StreamController<bool> connectionStatusController = StreamController<bool>();

  ConnectivityService() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      final value = await _getStatusFromResult(connectivityResult);
      connectionStatusController.add(value);
    });
  }

  Future<bool> _getStatusFromResult(ConnectivityResult result) async {
    final internetData = await InternetConnectionChecker().hasConnection;
    final bool _hasConnection;

    // check if the device is Wifi or mobile data is turned on
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      // check if user has internet data access
      if (internetData) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    } else {
      _hasConnection = false;
    }

    return _hasConnection;
  }
}
