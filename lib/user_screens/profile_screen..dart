import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/public_packages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: FutureBuilder(
            future: firebaseFirestore
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
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
                          NetworkImage(fetchedData!.get('profilePic')),
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
                    cards(
                      header: 'Address',
                      subHeader: fetchedData.get('province') +
                          '-' +
                          fetchedData.get('city'),
                      icon: Icons.person,
                    )
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: primaryGreen,
                ));
              }
            },
          ),
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
