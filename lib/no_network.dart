
import 'package:flutter/material.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/providers/network_providers.dart';
import 'package:kurdbid/public_packages.dart';

import 'components/colors.dart';


class NoNetwork extends StatefulWidget {
  const NoNetwork({super.key});

  @override
  State<NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  List<Widget> noNet = [];

  @override
  void initState() {
    super.initState();
    // load();
  }

  // Future<void> load() async {
  //   Future.delayed(const Duration(seconds: 5))
  //       .then((value) => checkConnection().then((value) {
  //             if (value) {
  //               Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => AppRouter.getPage()));
  //             }
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    bool isConnected = true;
    final nw = Provider.of<Network>(context, listen: false);
    nw.checkConnection();
    

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            getImage(
              folderName: 'icons',
              fileName: 'wifi.svg',
            ),
            width: 82.w,
            color: primaryGreen,
          ),
          textLabel(
            text: 'No internet connection',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20.sp,
          ),
          textLabel(
            text: 'Try these steps to get back online',
            fontSize: 18.sp,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          SizedBox(
            height: 14.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const InstructionBullet(
                content: 'Check your modem and router',
              ),
              SizedBox(
                height: 6.h,
              ),
              const InstructionBullet(
                content: 'Check you mobile data',
              ),
              SizedBox(
                height: 6.h,
              ),
              const InstructionBullet(content: 'Connect to WIFI'),

              //Spacer(),
              SizedBox(height: 38.h),
              primaryButton(
                onPressed: () {
                  nw.checkConnection();
                },
                label: 'Reload',
                backgroundColor: primaryGreen,
                size: Size(120.w, 50.h),
              )
            ],
          )
        ],
      ),
    );
  }
}

class InstructionBullet extends StatelessWidget {
  const InstructionBullet({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Spacer(),
        SizedBox(
          width: 60.w,
        ),
        CircleAvatar(
          backgroundColor: primaryGreen,
          radius: 10.r,
          child: SvgPicture.asset(
            getImage(
              folderName: 'icons',
              fileName: 'check.svg',
            ),
            width: 10.w,
            color: backgroundGrey1,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        textLabel(
          text: content,
          fontSize: 16.sp,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        const Spacer(),
      ],
    );
  }
}
