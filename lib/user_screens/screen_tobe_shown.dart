import 'package:kurdbid/main.dart';
import 'package:kurdbid/role.dart';
import 'package:kurdbid/shared_preferences/screens_state_manager.dart';
import 'package:kurdbid/user_screens/login_screen.dart';

class AppRouter {
  // A static-dynamic function to get screens based on their id to be shown
  static dynamic getPage() {
    int pageID = ScreenStateManager.getPageID();

    switch (pageID) {
      case 0:
        return const RoleScreen();
      case 1:
        return const LoginScreen();
      case 2:
        return const AllScreens();
    }
  }
}


/*

0 - OnboardingScreen
1 - RoleScreen
2 - LoginScreen
3 - AllScreen

*/