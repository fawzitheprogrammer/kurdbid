import 'package:kurdbid/admin_screen/id_previewer.dart';
import 'package:kurdbid/components/success_screen.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/providers/add_item_provider.dart';
import 'package:kurdbid/providers/approved_user.dart';
import 'package:kurdbid/public_packages.dart';

import '../components/components_barrel.dart';

class PendingUserInformationScreen extends StatelessWidget {
  const PendingUserInformationScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //print(userId);

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: firebaseFirestore.collection('users').doc(userId).snapshots(),
          builder: (context, snapshot) {
            final userInfo = snapshot.data;
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(24.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryGreen,
                          radius: 75.r,
                          backgroundImage: NetworkImage(
                            userInfo!.get('profilePic'),
                          ),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        textLabel(
                            text:
                                '${userInfo.get('firstName')} ${userInfo.get('lastName')}',
                            fontSize: 28.sp),
                        SizedBox(
                          height: 16.w,
                        ),
                        Row(
                          children: [
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textLabel(
                                    text:
                                        'Location : ${userInfo.get('province')}-${userInfo.get('city')}',
                                    fontSize: 18.sp),
                                textLabel(
                                  text:
                                      'Phone : ${userInfo.get('phoneNumber')}',
                                  fontSize: 18.sp,
                                ),
                                textLabel(
                                    text: 'Gender : ${userInfo.get('gender')}',
                                    fontSize: 18.sp),
                                textLabel(
                                  text:
                                      'ID Number : ${userInfo.get('idNumber')}',
                                  fontSize: 18.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        GestureDetector(
                          onTap: () => getPage(
                            context,
                            IdPreview(
                              frontSide: userInfo.get('frontIdCardUrl'),
                              backSide: userInfo.get('backIdCardUrl'),
                            ),
                          ),
                          child: fields(
                            userInfo.get('frontIdCardUrl'),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () => getPage(
                        //     context,
                        //     IdPreview(
                        //       src: userInfo.get('frontIdCardUrl'),
                        //     ),
                        //   ),
                        //   child: fields(
                        //     userInfo.get('frontIdCardUrl'),
                        //   ),
                        // ),
                        SizedBox(
                          height: 26.w,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: customButton(() {
                                updateDocuemnt(
                                        firestore: firebaseFirestore,
                                        parentCollection: 'users',
                                        userDocumentID: userId,
                                        isApproved: true)
                                    .then((value) {
                                  ItemAndPostProvider.sendPushMessage(
                                    'Admin accepted your account creation request\nnow you can post item and join bids',
                                    'Account Accepted',
                                    '${userInfo.get('deviceToken')}',
                                  );
                                  getPageRemoveUntil(
                                    context,
                                    const SuccessMessage(
                                      label: 'User Approved',
                                      body:
                                          'Now the user can post items and join bids',
                                    ),
                                  );
                                });
                              }, Icons.check, Colors.green),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: customButton(() {
                                updateDocuemnt(
                                        firestore: firebaseFirestore,
                                        parentCollection: 'users',
                                        userDocumentID: userId,
                                        isApproved: false)
                                    .then((value) {
                                  ItemAndPostProvider.sendPushMessage(
                                    'Admin declined your account creation request,\n please check your information and try again',
                                    'Account Declined',
                                    '${userInfo.get('deviceToken')}',
                                  );
                                  Navigator.pop(context);
                                });
                              }, Icons.close, Colors.red),
                            ),
                          ],
                        )
                        // Flexible(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     //crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       customButton(() {}, Icons.check, Colors.green),
                        //       SizedBox(
                        //         width: 6.w,
                        //       ),
                        //       customButton(() {}, Icons.close, Colors.red),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryGreen,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> updateDocuemnt(
      {required FirebaseFirestore firestore,
      required String parentCollection,
      required String userDocumentID,
      required bool isApproved}) {
    final documentReference =
        firestore.collection(parentCollection).doc(userDocumentID);

    return documentReference.update({'isApproved': isApproved});
  }

  Widget fields(url) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        height: 220.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: primaryGreen.shade300),
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: NetworkImage(
              url,
            ),
            fit: BoxFit.cover,
          ),
        ),
        // child: Image.network(url),
        // child: file == null
        //     ? Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           SvgPicture.asset(
        //             getImage(
        //               folderName: 'icons',
        //               fileName: 'id_add.svg',
        //             ),
        //             colorFilter: ColorFilter.mode(
        //               Colors.blueGrey[(3 + 1) * 100] ?? Colors.blueGrey,
        //               BlendMode.srcIn,
        //             ),
        //             width: 28.w,
        //           )

        //           // !needLabel ? const Spacer() : Text('')
        //         ],
        //
      ),
    );
  }
}
