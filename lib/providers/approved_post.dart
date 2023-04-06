import 'package:kurdbid/public_packages.dart';

class ApprovedPost extends ChangeNotifier {
  bool _approvedPost = false;

  bool get approvedPost => _approvedPost;

  void setValue(value) {
    _approvedPost = value;
    notifyListeners();
  }
}
