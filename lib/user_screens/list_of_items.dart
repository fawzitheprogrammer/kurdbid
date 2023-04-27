import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/components/progress_indicator.dart';
import 'package:kurdbid/user_screens/item_screen.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/public_packages.dart';

class ListOfItem extends StatelessWidget {
  const ListOfItem({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!.uid;

    // final data =
    //     firebaseFirestore.collection('users').get().then((userSnapshot) {
    //   userSnapshot.docs.forEach((element) {
    //     return firebaseFirestore
    //         .collection('users')
    //         .doc(element.id)
    //         .collection('posts')
    //         .where('category', isEqualTo: category)
    //         .snapshots();
    //   });
    // });

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.search),
      //     onPressed: () {},
      //   ),
      // ),
      body: SizedBox(
        child: StreamBuilder(
          stream: firebaseFirestore
              .collection('posts')
              .where('category', isEqualTo: category)
              .where('isApproved', isEqualTo: true)
              .snapshots()
              .map((querySnapshot) => querySnapshot.docs
                  .where((documentSnapshot) =>
                      DateTime.parse(documentSnapshot['duration'])
                          .isAfter(DateTime.now()))
                  .toList()),
          builder: (context, snapshot) {
            //print(snapshot.hasData);
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final fetchedData = snapshot.data!;

              List<Widget> itemCards = [];

              for (var item in fetchedData) {
                DateTime endDate = DateTime.parse(item.get('duration'));
                DateTime currentDate = DateTime.now();

                Duration difference = endDate.difference(currentDate);

                int days = difference.inDays;
                int hours = difference.inHours % 24;
                int minutes = difference.inMinutes % 60;

                //print('$days days, $hours hours, $minutes minutes');
                // print(difference.inHours % 24);

                //print(item.get('productName'));

                final createdItemCard = GestureDetector(
                  onTap: () => getPage(
                      context,
                      ItemScreen(
                        documentID: item.id,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(18.0.w),
                        child: Row(
                          children: [
                            Flexible(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.network(
                                  item.get('imgUrl'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textLabel(
                                  text: item.get('productName'),
                                  fontSize: 24.sp,
                                  color: Colors.black87,
                                ),
                                SizedBox(
                                  height: 12.w,
                                ),
                                Row(
                                  children: [
                                    DurationCard(
                                      duration: days.toString(),
                                      format: 'Day',
                                    ),
                                    DurationCard(
                                      duration: hours.toString(),
                                      format: 'Hour',
                                    ),
                                    DurationCard(
                                      duration: minutes.toString(),
                                      format: 'Min',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12.w,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  height: 50.h,
                                  width: 80.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: primaryGreen,
                                  ),
                                  child: Center(
                                    child: textLabel(
                                      text: '\$${item.get('startPrice')}',
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );

                if (item.get('userID') == user) {
                } else {
                  itemCards.add(createdItemCard);
                }
              }

              return itemCards.isNotEmpty
                  ? ListView(
                      children: itemCards,
                    )
                  : Center(
                      child: loading(),
                    );
            } else {
              return const Center(
                child:  Text('No posts yet.'),
              );
            }
            // return snapshot.hasData
            //     ?
            //     : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
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
