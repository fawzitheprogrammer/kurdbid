import 'package:kurdbid/public_packages.dart';

class ApprovedUser extends ChangeNotifier {
  bool _approvedUser = false;

  bool get approvedUser => _approvedUser;

  void setValue(value) {
    _approvedUser = value;
    notifyListeners();
  }
}
