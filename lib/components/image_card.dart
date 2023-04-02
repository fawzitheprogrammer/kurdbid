import 'package:kurdbid/public_packages.dart';

import 'components_barrel.dart';

Widget fields(String img, Size size,BoxFit? boxFit) {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: primaryGreen.shade300),
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: AssetImage(getImage(
            folderName: 'images',
            fileName: img,
          )),
          fit:boxFit ?? BoxFit.cover,
        ),
      ),
      //child: Image.asset(),
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
