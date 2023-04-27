import 'package:kurdbid/components/progress_indicator.dart';
import 'package:kurdbid/public_packages.dart';

import '../components/components_barrel.dart';
import '../components/image_card.dart';
import '../components/success_screen.dart';
import '../navigation/navigator.dart';
import '../providers/add_item_provider.dart';

class WinnerAndOwnerScreen extends StatelessWidget {
  const WinnerAndOwnerScreen({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                child: StreamBuilder(
                    stream: firebaseFirestore
                        .collection('posts')
                        .doc(itemId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //
                        final postInfo = snapshot.data;

                        ///
                        DateTime endDate =
                            DateTime.parse(postInfo!.get('duration'));
                        DateTime currentDate = DateTime.now();

                        //print(DateTime.now());

                        Duration difference = endDate.difference(currentDate);

                        int days = difference.inDays;
                        int hours = difference.inHours % 24;
                        int minutes = difference.inMinutes % 60;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LimitedBox(
                              maxHeight: 300.h,
                              maxWidth: 100.w,
                              child: fields(postInfo.get('imgUrl'),
                                  Size(100.w, 300.h), BoxFit.fitHeight),
                            ),
                            SizedBox(
                              height: 16.w,
                            ),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textLabel(
                                    text:
                                        'Category : ${postInfo.get('category')}',
                                    fontSize: 18.sp),
                                textLabel(
                                  text:
                                      'Published By : ${postInfo.get('userName')}',
                                  fontSize: 18.sp,
                                ),
                                textLabel(
                                  text: 'Address : ${postInfo.get('address')}',
                                  fontSize: 18.sp,
                                ),
                                textLabel(
                                  text: 'Phone : ${postInfo.get('userPhone')}',
                                  fontSize: 18.sp,
                                ),
                                Row(
                                  children: [
                                    textLabel(
                                      text: 'Start Price : ',
                                      fontSize: 18.sp,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      height: 40.h,
                                      width: 80.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: primaryGreen,
                                      ),
                                      child: Center(
                                        child: textLabel(
                                          text:
                                              '\$${postInfo.get('startPrice')}',
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textLabel(
                                  text: 'Winner : ${postInfo.get('buyerName')}',
                                  fontSize: 18.sp,
                                ),
                                textLabel(
                                  text: 'Phone : ${postInfo.get('buyerPhone')}',
                                  fontSize: 18.sp,
                                ),
                                Row(
                                  children: [
                                    textLabel(
                                        text: 'Winner Price : ',
                                        fontSize: 18.sp),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      height: 40.h,
                                      width: 80.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: primaryGreen,
                                      ),
                                      child: Center(
                                        child: textLabel(
                                          text:
                                              '\$${postInfo.get('buyerPrice')}',
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return loading();
                      }
                    }),
              ),
            ),
          ),
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

  // Widget fields() {
  //   return GestureDetector(
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 14.w),
  //       height: 220.h,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         border: Border.all(width: 1.5, color: primaryGreen.shade300),
  //         borderRadius: BorderRadius.circular(10.r),
  //       ),
  //       child: Image.asset(getImage(folderName: 'images', fileName: 'bid.png')),
  //       // child: file == null
  //       //     ? Row(
  //       //         mainAxisAlignment: MainAxisAlignment.center,
  //       //         children: [
  //       //           SvgPicture.asset(
  //       //             getImage(
  //       //               folderName: 'icons',
  //       //               fileName: 'id_add.svg',
  //       //             ),
  //       //             colorFilter: ColorFilter.mode(
  //       //               Colors.blueGrey[(3 + 1) * 100] ?? Colors.blueGrey,
  //       //               BlendMode.srcIn,
  //       //             ),
  //       //             width: 28.w,
  //       //           )

  //       //           // !needLabel ? const Spacer() : Text('')
  //       //         ],
  //       //
  //     ),
  //   );
  // }
}

class DurationCard extends StatelessWidget {
  const DurationCard({super.key, required this.duration, required this.format});

  final String duration;
  final String format;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: Column(children: [
        Container(
          height: 50.h,
          width: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: primaryGreen,
          ),
          child: Center(
            child: textLabel(
              text: duration,
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
        ),
        textLabel(text: format)
      ]),
    );
  }
}
