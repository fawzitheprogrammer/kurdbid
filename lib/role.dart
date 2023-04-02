import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:kurdbid/shared_preferences/role.dart';
import 'package:kurdbid/user_screens/login_screen.dart';

import '../../shared_preferences/shared_pref_barrel.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Role role = Role();

    goToPage(bool isUser) {
      Role.setIsUser(isUser: isUser).then(
        (value) {
          ScreenStateManager.setPageOrderID(1);
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false);
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textLabel(
                  text: 'How do you want to continue ?',
                  fontSize: 22,
                  color: colorScheme.onPrimary.withAlpha(120),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoleCard(
                      onTap: () {
                        goToPage(false);
                      },
                      header: 'Admin',
                      image: 'businessman.png',
                      cColor: primaryGreen.withAlpha(40),
                    ),
                    RoleCard(
                      onTap: () {
                        goToPage(true);
                      },
                      header: 'User',
                      image: 'man.png',
                      cColor: Colors.blue.withAlpha(40),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  RoleCard({
    super.key,
    required this.header,
    required this.image,
    required this.cColor,
    required this.onTap,
  });

  final String header;

  final String image;
  final Color cColor;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(12.0.w),
          margin: EdgeInsets.all(4.0.w),
          height: 180.h,
          width: 180.w,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withAlpha(60),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: CircleAvatar(
                  backgroundColor: cColor,
                  radius: 52.r,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipOval(
                      child: Image.asset(
                        getImage(
                          folderName: 'vectors',
                          fileName: image,
                        ),
                        width: 80.w,
                      ),
                    ),
                  ),
                ),
              ),
              textLabel(
                text: header,
                fontSize: 18.sp,
                //fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary.withAlpha(200),
              ),
            ],
          )),
    );
  }
}
