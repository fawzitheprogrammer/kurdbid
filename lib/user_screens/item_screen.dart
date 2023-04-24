import 'dart:async';

import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/main.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/providers/bottom_narbar_provider.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:kurdbid/shared_preferences/role.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.documentID});

  final String documentID;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  int myPrice = 0;
  Timer? _timer;
  bool priceSet = false;

  void _startTimer(bool isNeg) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (isNeg && myPrice != 0) {
          myPrice--;
        } else {
          myPrice++;
        }
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrice();
  }

  void initPrice() async {
    await PriceSet.init();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!.uid;
    final bottomNavProvider = Provider.of<BottomNavBar>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: StreamBuilder(
          builder: (context, snapshot) {
            return StreamBuilder(
              stream: firebaseFirestore
                  .collection('posts')
                  .doc(widget.documentID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final fetchedData = snapshot.data;

                  DateTime endDate =
                      DateTime.parse(fetchedData!.get('duration'));
                  DateTime currentDate = DateTime.now();

                  Duration difference = endDate.difference(currentDate);

                  int days = difference.inDays;
                  int hours = difference.inHours % 24;
                  int minutes = difference.inMinutes % 60;

                  myPrice == 0
                      ? myPrice = int.parse(fetchedData.get('buyerPrice'))
                      : null;

                  bool timeDone = currentDate.isBefore(endDate) &&
                      fetchedData.get('buyerId') == user;

                  print(fetchedData.get('productName'));

                  return Column(
                    children: [
                      Container(
                        height: 250.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                        ),
                        child: Image.network(
                          fetchedData.get('imgUrl'),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      textLabel(
                        text: fetchedData.get('productName'),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      // timeDone
                      //     ? textLabel(text: 'Your Price', color: darkGrey2)
                      //     : Container(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     textLabel(
                      //       text: '\$${fetchedData.get('buyerPrice')}',
                      //       color: Colors.green,
                      //       fontSize: 22.sp,
                      //     ),
                      //     const Icon(
                      //       Icons.check,
                      //       color: Colors.green,
                      //     )
                      //   ],
                      // ),
                      // timeDone
                      //     ? textLabel(text: 'Your Price', color: darkGrey2)
                      //     : Container(),
                      Column(
                        children: [
                          textLabel(text: 'Owner Price', color: darkGrey2),
                          textLabel(
                            text: '\$${fetchedData.get('startPrice')}',
                            color: darkGrey2,
                            fontSize: 22.sp,
                          ),
                          textLabel(text: 'Current Price', color: darkGrey2),
                          textLabel(
                            text: '\$${fetchedData.get('buyerPrice')}',
                            color: darkGrey2,
                            fontSize: 22.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: 50.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: primaryGreen,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: icons(
                                iconData: Icons.add,
                                onTapDown: (details) {
                                  _startTimer(false);
                                },
                                onTapUp: (details) {
                                  _stopTimer();
                                },
                                onTapCancel: () {
                                  _stopTimer();
                                },
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: textLabel(
                                  text: '\$$myPrice',
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Flexible(
                              child: icons(
                                iconData: Icons.remove,
                                onTapDown: (details) {
                                  _startTimer(true);
                                },
                                onTapUp: (details) {
                                  _stopTimer();
                                },
                                onTapCancel: () {
                                  _stopTimer();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      primaryButton(
                        onPressed: () async {
                          //await PriceSet.init();
                          if (myPrice > fetchedData.get('buyerPrice')) {
                            final user = FirebaseAuth.instance.currentUser!.uid;
                            // Create a reference to a new document
                            final userData = getUserData('users', user).get();

                            userData.then((value) async {
                              // Create a Map to be saved in the document
                              final Map<String, dynamic> data = {
                                'buyerPrice': myPrice.toString(),
                                'buyerName': value.get('firstName') +
                                    ' ' +
                                    value.get('lastName'),
                                'buyerId': value.id,
                                'buyerPhone': value.get('phoneNumber')
                              };

                              // Save the Map in the new document
                              await getUserData('posts', widget.documentID)
                                  .update(data);
                            }).then((value) {
                              bottomNavProvider.bottomNavIndex(0);
                              getPageRemoveUntil(
                                context,
                                const AllScreens(),
                              );
                            });

                            //PriceSet.priceIsSet(isUser: true);
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('You have to provide a higher price'),
                              ),
                            );
                          }
                        },
                        label: 'Bid',
                        backgroundColor: Colors.green,
                        size: Size(
                          180.w,
                          50.h,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          },
        )),
      ),
    );
  }

  DocumentReference getUserData(String collection, String documment) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference documentReference =
        firestore.collection(collection).doc(documment);
    return documentReference;
  }

  Widget icons({
    required IconData iconData,
    void Function(TapDownDetails)? onTapDown,
    void Function(TapUpDetails)? onTapUp,
    void Function()? onTapCancel,
  }) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      child: Icon(
        iconData,
        color: Colors.white,
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
          height: 80.h,
          width: 80.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: primaryGreen,
          ),
          child: Center(
            child: textLabel(
              text: duration,
              color: Colors.white,
              fontSize: 28.sp,
            ),
          ),
        ),
        textLabel(text: format)
      ]),
    );
  }
}
