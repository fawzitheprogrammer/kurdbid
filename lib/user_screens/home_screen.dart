import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/public_packages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

      //   ,
      body: SizedBox(
        child: StreamBuilder(
          stream: firebaseFirestore.collection('users').doc(user).snapshots(),
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (snapshot.hasData) {
              return StreamBuilder(
                stream: firebaseFirestore
                    .collection('posts')
                    .where('buyerId', isEqualTo: user)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final fetchData = snapshot.data!.docs;

                    List<Widget> itemCards = [];
                    for (var item in fetchData) {
                      DateTime endDate = DateTime.parse(item!.get('duration'));
                      DateTime currentDate = DateTime.now();

                      //print(DateTime.now());

                      Duration difference = endDate.difference(currentDate);

                      int days = difference.inDays;
                      int hours = difference.inHours % 24;
                      int minutes = difference.inMinutes % 60;

                      bool timeDone = currentDate.isBefore(endDate) &&
                          item.get('buyerId') == user;

                      Color cardColor() {
                        if (currentDate.isAfter(endDate) &&
                            item.get('buyerId') == user) {
                          return Colors.greenAccent.withAlpha(50);
                        } else if (endDate == currentDate &&
                            item.get('buyerId') != user) {
                          return Colors.redAccent.withAlpha(30);
                        } else {
                          return Theme.of(context).colorScheme.primaryContainer;
                        }
                      }

                      final itemCard = Padding(
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
                                        : Row(
                                            children: [
                                              textLabel(
                                                  text: 'You won this item for',
                                                  color: Colors.green,
                                                  //fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp),
                                            ],
                                          ),
                                    timeDone
                                        ? SizedBox(
                                            height: 12.w,
                                          )
                                        : Container(),
                                    timeDone
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textLabel(
                                                  text: 'Initial Price',
                                                  color: darkGrey2),
                                              textLabel(
                                                text:
                                                    '\$${item.get('startPrice')}',
                                                color: darkGrey2,
                                                fontSize: 14.sp,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    timeDone
                                        ? textLabel(
                                            text: 'Your Price',
                                            color: darkGrey2)
                                        : Container(),
                                    Row(
                                      children: [
                                        textLabel(
                                          text: '\$${item.get('buyerPrice')}',
                                          color: !timeDone
                                              ? Colors.green
                                              : darkGrey2,
                                          fontSize: timeDone ? 14.sp : 22.sp,
                                        ),
                                        !timeDone
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )
                                            : Container(),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );

                      itemCards.add(itemCard);
                    }

                    return itemCards.isNotEmpty
                        ? ListView(
                            children: itemCards,
                          )
                        : Center(
                            child: textLabel(
                                text: 'You haven\'t joined any bid so far',
                                color: midGrey1),
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryGreen,
                      ),
                    );
                  }
                },
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
          height: 40.h,
          width: 40.h,
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
