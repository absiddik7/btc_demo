import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isOnline = true; // Default to false until verified
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _init();
  }

  Future<void> _init() async {
    await _checkInitialConnection();
    _subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      _updateConnectionStatus(connectivityResult);
    } catch (e) {
      // Handle potential errors, e.g., by logging them
      _isOnline = false; // Assume offline on error
      notifyListeners(); // Notify listeners on error
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    bool newOnlineStatus =
        result.isNotEmpty && result.first != ConnectivityResult.none;
    if (_isOnline != newOnlineStatus) {
      _isOnline = newOnlineStatus;
      notifyListeners(); // Notify only on actual change
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  ///reload funtionality
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> checkAndReload() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 5));

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// class ReloadProvider with ChangeNotifier {
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   Future<void> checkAndReload() async {
//     _isLoading = true;
//     notifyListeners();

//     await Future.delayed(const Duration(seconds: 5));

//     final connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       _isLoading = false;
//       notifyListeners();
//     } else {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
