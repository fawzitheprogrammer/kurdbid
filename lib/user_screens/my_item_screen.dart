import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/public_packages.dart';

class MyItemScreen extends StatelessWidget {
  const MyItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!.uid;

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
            .where('userID', isEqualTo: user)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final fetchedData = snapshot.data!.docs;

            List<Widget> itemCards = [];

            for (var item in fetchedData) {
              DateTime endDate = DateTime.parse(item.get('duration'));
              DateTime currentDate = DateTime.now();

              Duration difference = endDate.difference(currentDate);

              int days = difference.inDays;
              int hours = difference.inHours % 24;
              int minutes = difference.inMinutes % 60;

              bool timeDone = currentDate.isBefore(endDate);

              Color cardColor() {
                if (currentDate.isAfter(endDate) &&
                    item.get('buyerId') != null) {
                  return Colors.greenAccent.withAlpha(50);
                } else if (endDate == currentDate &&
                    item.get('buyerId') == null) {
                  return Colors.redAccent.withAlpha(30);
                } else {
                  return Theme.of(context).colorScheme.primaryContainer;
                }
              }

              //print('$days days, $hours hours, $minutes minutes');
              //print(difference.inHours % 24);

              final createdItemCard = Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: cardColor(),
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
                            timeDone
                                ? Row(
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
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textLabel(
                                        text: 'This item was sold to',
                                        color: Colors.green,
                                        //fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                      textLabel(
                                        text: item.get('buyerName'),
                                        fontSize: 18.sp,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Row(
                                        children: [
                                          textLabel(
                                            text: 'for  ',
                                            color: Colors.green,
                                            //fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                          textLabel(
                                            text: '\$${item.get('buyerPrice')}',
                                            fontSize: 16.sp,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                            SizedBox(
                              height: 12.w,
                            ),
                           !timeDone ? Container() : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
              );

              itemCards.add(createdItemCard);
            }

            return ListView(
              children: itemCards,
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: primaryGreen,
            ));
          }
          // return snapshot.hasData
          //     ?
          //     : const CircularProgressIndicator();
        },
      )),
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
