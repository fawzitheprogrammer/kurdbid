import 'package:kurdbid/admin_screen/single_item.dart';
import 'package:kurdbid/admin_screen/winner_and_owner.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/components/image_card.dart';
import 'package:kurdbid/components/progress_indicator.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/providers/approved_post.dart';
import 'package:kurdbid/public_packages.dart';

class WinnerScreen extends StatelessWidget {
  const WinnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final au = Provider.of<ApprovedPost>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // PopupMenuButton(
          //   //color: primaryGreen,
          //   icon: Icon(Icons.more_vert, color: primaryGreen),
          //   //surfaceTintColor: backgroundGrey2,
          //   onSelected: (value) {
          //     au.setValue(value);

          //     //print();
          //   },
          //   itemBuilder: (context) => [
          //     const PopupMenuItem(
          //       value: true,
          //       child: Text('Approved posts'),
          //     ),
          //     const PopupMenuItem(
          //       value: false,
          //       child: Text('Pending posts'),
          //     ),
          //   ],
          // )
        ],
        elevation: 0.1,
      ),
      body: SizedBox(
        child: StreamBuilder(
          stream: firebaseFirestore.collection('posts').snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.docs;

              List<Widget> allPosts = [];
              for (var post in data) {
                bool isPostApproved = post.get('isApproved');

                DateTime endDate = DateTime.parse(post!.get('duration'));
                DateTime currentDate = DateTime.now();
                Duration difference = endDate.difference(currentDate); //
                // int days = difference.inDays;
                // int hours = difference.inHours % 24;
                // int minutes = difference.inMinutes % 60;

                if (endDate.isBefore(currentDate)) {
                  final singlePost = Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => getPage(
                          context, WinnerAndOwnerScreen(itemId: post.id)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withAlpha(80),
                        ),
                        height: 150.h,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(24.0.w),
                          child: Row(
                            children: [
                              LimitedBox(
                                maxHeight: 100.h,
                                maxWidth: 100.w,
                                child: fields(
                                  post.get('imgUrl'),
                                  Size(
                                    100.w,
                                    100.h,
                                  ),
                                  BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textLabel(
                                      text: post.get('productName'),
                                      fontSize: 20.sp,
                                    ),
                                    textLabel(
                                      text: 'Owner : ${post.get('userName')}',
                                      fontSize: 14.sp,
                                    ),
                                    textLabel(
                                      text: 'Winner : ${post.get('buyerName')}',
                                      fontSize: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                              // Spacer(),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     SvgPicture.asset(
                              //       getImage(
                              //         folderName: 'icons',
                              //         fileName: !isPostApproved
                              //             ? 'pending.svg'
                              //             : 'check.svg',
                              //       ),
                              //       color: !isPostApproved
                              //           ? Colors.orange
                              //           : Colors.green,
                              //       width: 24.w,
                              //     ),
                              //     SizedBox(
                              //       height: 4.h,
                              //     ),
                              //     textLabel(
                              //       text:
                              //           !isPostApproved ? 'Pending' : 'Approved',
                              //       fontSize: 10.sp,
                              //       color: !isPostApproved
                              //           ? Colors.orange
                              //           : Colors.green,
                              //     )
                              //   ],
                              // ),
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
                    ),
                  );

                  allPosts.add(singlePost);
                }
              }

              return allPosts.isNotEmpty
                  ? ListView(
                      children: allPosts,
                    )
                  : Center(
                      child: textLabel(text: 'There is no pending post yet.'),
                    );
            } else {
              return loading();
            }
          }),
        ),
      ),
    );
  }
}
