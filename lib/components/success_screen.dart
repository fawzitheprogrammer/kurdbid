import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/main.dart';
import 'package:kurdbid/navigation/navigator.dart';
import 'package:kurdbid/providers/providers_barrel.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:rive/rive.dart';


class SuccessMessage extends StatefulWidget {
  const SuccessMessage({super.key, required this.label, required this.body});

  final String label;
  final String body;

  @override
  State<SuccessMessage> createState() => _SuccessMessageState();
}

class _SuccessMessageState extends State<SuccessMessage> {
  @override
  Widget build(BuildContext context) {
    // final appointmentProvider =
    //     Provider.of<AppointmentProvider>(context, listen: false);

    final provider = Provider.of<BottomNavBar>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 160.h,
              width: 160.w,
              child: const RiveAnimation.asset('assets/rive/done.riv'),
            ),
            textLabel(
              text: widget.label,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 4.h,
            ),
            textLabel(
                text: widget.body,
                fontSize: 13.sp,
                color: Theme.of(context).colorScheme.onPrimary.withAlpha(120),
                textAlign: TextAlign.center),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.0.h),
              child: primaryButton(
                onPressed: () {
                  provider.bottomNavIndex(0);
                  getPageRemoveUntil(
                    context,
                    const AllScreens(),
                  );
                },
                label: 'Done',
                backgroundColor: primaryGreen,
                size: Size(
                  double.infinity,
                  60.h,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
