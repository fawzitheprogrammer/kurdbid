import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/components/progress_indicator.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:kurdbid/user_screens/login_screen.dart';

import '../providers/auth_provider.dart';
import '../providers/bottom_narbar_provider.dart';
import '../role.dart';
import '../shared_preferences/screens_state_manager.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final ap = Provider.of<AuthProvider>(context, listen: true);
    final bottomNavProvider = Provider.of<BottomNavBar>(context, listen: true);

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: user != null
              ? FutureBuilder(
                  future: firebaseFirestore
                      .collection('admin')
                      .doc(user!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final fetchedData = snapshot.data;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Spacer(),
                          CircleAvatar(
                            radius: 80.r,
                            backgroundImage:
                                NetworkImage(fetchedData!.get('profileImgUrl')),
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          cards(
                            header: 'Username',
                            subHeader: fetchedData.get('firstName') +
                                ' ' +
                                fetchedData.get('lastName'),
                            icon: Icons.person,
                          ),
                          cards(
                            header: 'Phone',
                            subHeader: fetchedData.get('phoneNumber'),
                            icon: Icons.phone,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 44.0.w, vertical: 24.h),
                            child: primaryButton(
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
                            ),
                          )
                          // cards(
                          //   header: 'Address',
                          //   subHeader: fetchedData.get('province') +
                          //       '-' +
                          //       fetchedData.get('city'),
                          //   icon: Icons.person,
                          // )
                        ],
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: primaryGreen,
                      ));
                    }
                  },
                )
              : loading(),
        ),
      ),
    );
  }

  Widget cards({
    required String header,
    required String subHeader,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 52.0.w, vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///Spacer(),
          CircleAvatar(
            radius: 30.r,
            child: Icon(icon),
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textLabel(text: header, fontSize: 20.sp),
              textLabel(text: subHeader)
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
