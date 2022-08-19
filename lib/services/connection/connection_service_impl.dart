import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'connection_service.dart';

class ConnectionServiceImpl implements ConnectionService {
  late final Connectivity _connectivity;
  bool _hasConnection = false;
  final StreamController<bool> _connectionChangeController =
      StreamController.broadcast();

  ConnectionServiceImpl() {
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen(_onConnectivityChange);
  }

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  void _onConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _hasConnection = false;
      _connectionChangeController.add(false);
      return;
    }

    checkConnection();
  }

  void dispose() {
    _connectionChangeController.close();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = _hasConnection;

    try {
      final result = await InternetAddress.lookup("google.com");

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    } on SocketException catch (_) {
      _hasConnection = false;
    }

    if (previousConnection != _hasConnection) {
      _connectionChangeController.add(_hasConnection);
    }

    return _hasConnection;
  }
}
