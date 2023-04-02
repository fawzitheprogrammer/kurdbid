import 'package:kurdbid/public_packages.dart';

import '../components/components_barrel.dart';

class PendingUserInformationScreen extends StatelessWidget {
  const PendingUserInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: primaryGreen,
                    radius: 75.r,
                    child: Icon(
                      Icons.person,
                      size: 50.r,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
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
                          textLabel(
                              text: 'Location : Erbil, Soran', fontSize: 18.sp),
                          textLabel(
                              text: 'Phone : 07501002302', fontSize: 18.sp),
                          textLabel(
                              text: 'Address : Erbil, Soran', fontSize: 18.sp),
                          textLabel(text: 'Gender : Male', fontSize: 18.sp),
                          textLabel(
                            text: 'ID Number : 3423423423',
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  fields(),
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
    );
  }

  Widget fields() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        height: 220.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: primaryGreen.shade300),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Image.asset(getImage(folderName: 'images', fileName: 'bid.png')),
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
