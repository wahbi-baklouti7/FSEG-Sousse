import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fseg_sousse/utilities/connectivity_status_enum.dart';

class ConnectivityService extends ChangeNotifier {
  late bool _hasConnection;

  bool? get hasConnection => _hasConnection;

  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      final value = await _getStatusFromResult(connectivityResult);

      connectionStatusController.add(value);
    });
  }

  Future<ConnectivityStatus> _getStatusFromResult(
      ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      return ConnectivityStatus.offline;
    } else {
      final status = await checkInternetConnection();
      print("checkInternetConnection status: $status");
      return status;
    }
  }

  Future<ConnectivityStatus> checkInternetConnection() async {
    try {
      List<InternetAddress> result1 =
          await InternetAddress.lookup('google.com');
      List<InternetAddress> result2 =
          await InternetAddress.lookup('facebook.com');

      if (result1.isNotEmpty && result1[0].rawAddress.isNotEmpty ||
          result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) {
        return ConnectivityStatus.online; //TODO:fix no internet check connection
      } else {
        return ConnectivityStatus.offline;
      }
    } on SocketException catch (_) {
      return ConnectivityStatus.offline;
    }catch(e){
      return ConnectivityStatus.offline;
    }
    
  }
}
