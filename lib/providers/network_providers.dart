import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kurdbid/public_packages.dart';

class Network extends ChangeNotifier {
  bool isConnected = true;

  Future<void> checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConnected = true;
      //print(isConnected);
      notifyListeners();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
      //print(isConnected);
      notifyListeners();
    } else {
      isConnected = false;
      //print(isConnected);
      notifyListeners();
    }
  }
}
