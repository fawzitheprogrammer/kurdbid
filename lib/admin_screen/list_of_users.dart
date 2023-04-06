import 'package:kurdbid/admin_screen/user_information_screen.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/providers/approved_user.dart';
import 'package:kurdbid/public_packages.dart';

class ListOfUsers extends StatelessWidget {
  const ListOfUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final au = Provider.of<ApprovedUser>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          PopupMenuButton(
            //color: primaryGreen,
            // icon: Icon(color: primaryGreen),
            //surfaceTintColor: backgroundGrey2,
            onSelected: (value) {
              au.setValue(value);

              //print();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: true,
                child: Text('Approved users'),
              ),
              const PopupMenuItem(
                value: false,
                child: Text('Pending users'),
              ),
            ],
          )
        ],
        elevation: 0.1,
      ),
      body: SizedBox(
        child: StreamBuilder(
          stream: firebaseFirestore
              .collection('users')
              .where('isApproved', isEqualTo: au.approvedUser)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.docs;

              List<Widget> userList = [];
              for (var user in data) {
                bool isApproved = user.get('isApproved');

                final userCard = GestureDetector(
                  onTap: () => getPage(
                    context,
                    PendingUserInformationScreen(
                      userId: user.id,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withAlpha(60),
                      ),
                      height: 150.h,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(24.0.w),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CircleAvatar(
                              backgroundColor: primaryGreen,
                              radius: 35.r,
                              backgroundImage:
                                  NetworkImage(user.get('profilePic')),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textLabel(
                                    text: user.get('firstName'),
                                    fontSize: 20.sp),
                                textLabel(
                                    text:
                                        '${user.get('province')}, ${user.get('city')}',
                                    fontSize: 14.sp),
                                textLabel(
                                    text: user.get(
                                      'idNumber',
                                    ),
                                    fontSize: 14.sp),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  getImage(
                                    folderName: 'icons',
                                    fileName: !isApproved
                                        ? 'pending.svg'
                                        : 'check.svg',
                                  ),
                                  color: !isApproved
                                      ? Colors.orange
                                      : Colors.green,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                textLabel(
                                  text: !isApproved ? 'Pending' : 'Approved',
                                  fontSize: 10.sp,
                                  color: !isApproved
                                      ? Colors.orange
                                      : Colors.green,
                                )
                              ],
                            ),
                            // Flexible(
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     //crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       customButton(() {
                            //         updateDocuemnt(
                            //           firestore: firebaseFirestore,
                            //           parentCollection: 'users',
                            //           userDocumentID: user.id,
                            //         );
                            //       }, Icons.check, Colors.green),
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

                userList.add(userCard);
              }

              return ListView(
                children: userList,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  // Future<void> updateDocuemnt({
  //   required FirebaseFirestore firestore,
  //   required String parentCollection,
  //   required String userDocumentID,
  // }) {
  //   final documentReference =
  //       firestore.collection(parentCollection).doc(userDocumentID);

  //   return documentReference.update({'isApproved': true});
  // }
}
