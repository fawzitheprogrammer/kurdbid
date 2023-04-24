import 'package:kurdbid/components/colors.dart';
import 'package:kurdbid/public_packages.dart';

class CheckCardColor extends ChangeNotifier {
  Color _color = Color.fromARGB(255, 200, 226, 255);

  Color get cardColor => _color;

  void init() {
    notifyListeners();
  }

  void setValue(bool value) {
    if (value == true) {
      _color = Colors.greenAccent.withAlpha(50);
    } else if (value == false) {
      _color = Color.fromARGB(255, 200, 226, 255);
    } else {
      _color = const Color.fromARGB(255, 200, 226, 255);
    }
  }

  notifyListeners();
}
