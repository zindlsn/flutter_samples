import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionAvailabilityService {
  Future<bool> hasInternetConnection() async {
    bool hasInternetConnection = false;
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      hasInternetConnection = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      hasInternetConnection = true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      hasInternetConnection = true;
    }

    return Future.value(hasInternetConnection);
  }
}
