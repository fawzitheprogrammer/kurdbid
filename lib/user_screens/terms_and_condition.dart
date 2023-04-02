import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kurdbid/components/assets_path%20copy.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/public_packages.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                child: Text(
                  terms,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                primaryButton(
                  label: 'Decline',
                  backgroundColor: Colors.redAccent,
                  size: Size(140.w, 50.h),
                ),
                SizedBox(
                  width: 8.0.w,
                ),
                primaryButton(
                  label: 'Accept',
                  backgroundColor: Colors.green,
                  size: Size(140.w, 50.h),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
