import 'package:kurdbid/public_packages.dart';

import '../components/components_barrel.dart';
import '../components/image_card.dart';

class SingleItemScreen extends StatelessWidget {
  const SingleItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LimitedBox(
                      maxHeight: 300.h,
                      maxWidth: 100.w,
                      child: fields(
                          'watch.jpg', Size(100.w, 300.h), BoxFit.fitHeight),
                    ),
                    SizedBox(
                      height: 18.w,
                    ),
                    textLabel(text: 'Muhamad Kamal', fontSize: 28.sp),
                    SizedBox(
                      height: 16.w,
                    ),
                    Row(
                      children: [
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                textLabel(
                                    text: 'Start Price : ', fontSize: 18.sp),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  height: 40.h,
                                  width: 80.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: primaryGreen,
                                  ),
                                  child: Center(
                                    child: textLabel(
                                      text: '\$120',
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.w,
                            ),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                textLabel(text: 'Duration : ', fontSize: 18.sp),
                                const DurationCard(
                                  duration: '1',
                                  format: 'Day',
                                ),
                                const DurationCard(
                                  duration: '1',
                                  format: 'Hour',
                                ),
                                const DurationCard(
                                  duration: '1',
                                  format: 'Min',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.w,
                            ),
                            textLabel(
                                text: 'Category : Electronics',
                                fontSize: 18.sp),
                            textLabel(
                                text: 'Published By : Muhamad Kamal',
                                fontSize: 18.sp),
                            textLabel(
                              text: 'Address : Erbil, Soran',
                              fontSize: 18.sp,
                            ),
                            textLabel(
                              text: 'Phone : 07503202383',
                              fontSize: 18.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                    // SizedBox(
                    //   height: 16.w,
                    // ),
                    // fields(),
                    SizedBox(
                      height: 26.w,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(() {}, Icons.check, Colors.green),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                          child: customButton(() {}, Icons.close, Colors.red),
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
          ),
        ),
      ),
    );
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
