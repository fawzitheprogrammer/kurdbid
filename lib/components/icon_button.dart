
import 'package:kurdbid/public_packages.dart';

Widget customButton(void Function()? onTap, IconData iconData, Color color) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(12.r)),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    ),
  );
}
