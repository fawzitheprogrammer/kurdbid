import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/providers/providers_barrel.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:kurdbid/user_screens/login_screen.dart';
import 'package:kurdbid/user_screens/my_item_screen.dart';

import '../role.dart';
import '../shared_preferences/screens_state_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: true);
    final bottomNavProvider = Provider.of<BottomNavBar>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0.w),
            child: Column(
              children: [
                button(
                  context,
                  'My Items',
                  Icons.category_outlined,
                  () => getPage(
                    context,
                    const MyItemScreen(),
                  ),
                ),
                button(context, 'Language', Icons.language, () {}),
                button(context, 'Privacy & Policies',
                    Icons.privacy_tip_outlined, () {}),
                button(context, 'Terms & Condition', Icons.list, () {}),
                button(context, 'About Us', Icons.info_outline, () {}),
                button(context, 'Contact Us', Icons.contact_support_outlined,
                    () {}),
                button(context, 'Notification',
                    Icons.notifications_active_outlined, () {}),
                button(
                    context, 'Share', Icons.share_arrival_time_outlined, () {}),
                SizedBox(
                  height: 22.h,
                ),
                primaryButton(
                  onPressed: () {
                    ap.userSignOut().then((value) {
                      bottomNavProvider.bottomNavIndex(0);
                      ScreenStateManager.setPageOrderID(0);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    });
                  },
                  label: 'Log out',
                  backgroundColor: primaryGreen,
                  size: Size(double.infinity, 50.h),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context, String label, IconData leadingIcon,
      void Function()? func) {
    return GestureDetector(
      onTap: func,
      child: Padding(
        padding: EdgeInsets.all(4.0.w),
        child: Container(
          padding: EdgeInsets.all(8.0.w),
          height: 50.h,
          decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(80),
              borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Icon(
                  leadingIcon,
                  color: primaryGreen,
                ),
              ),
              textLabel(
                  text: label,
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.onPrimary),
              const Spacer(),
              Icon(
                Icons.arrow_right_outlined,
                size: 28.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
