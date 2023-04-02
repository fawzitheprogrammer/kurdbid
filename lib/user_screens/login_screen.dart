import 'package:kurdbid/public_packages.dart';
import '../components/components_barrel.dart';
import '../providers/providers_barrel.dart';

String? phoneNumberOnBoarding = '+964075070860121';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Check if textfield is active
  bool isActive = false;

  // Individual gradient color for the shader
  Color gradientTop = Colors.transparent;
  Color gradientBottom = Colors.transparent;

  final RegExp phoneNumberRegex = RegExp(
      r'^\+964(0?751|0?750|0?782|0?783|0?784|0?79[0-9]|0?77[0-9])[0-9]{7}$');

  /// +9647518070601
  // 7510000000
  String countryCode = '+964';

  final TextEditingController phoneNumber = TextEditingController();

  String errorMessage = '';

  bool isLoading = false;

  // checkBackgroundColor() {
  //   if (isActive) {
  //     gradientTop = gradientTopGreen;
  //     gradientBottom = Colors.white.withOpacity(0.6);
  //   } else {
  //     gradientTop = Colors.transparent;
  //     gradientBottom = Colors.transparent;
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    //final ap = Provider.of<AuthProvider>(context, listen: false);
    //debugPrint(phoneNumber.text);

    //debugPrint(Role.getRole().toString());

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LimitedBox(
              maxHeight: 250.h,
              maxWidth: 350.w,
              child: SizedBox(
                //alignment: Alignment.topCenter,
                height: 300.h,
                width: 450.w,
                child: Image.asset(
                  getImage(folderName: 'images', fileName: 'p1.png'),
                  height: 588.38.h,
                  width: 289.55.w,
                ),
              ),
            ),
            // AnimatedContainer(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [gradientTop, gradientBottom],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     ),
            //   ),
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeInOut,
            // ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 26.h,
                  // ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                    child: SizedBox(
                      width: 314.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            height: 70.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                                child: Text(
                              '+964',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: primaryGreen,
                                //fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Expanded(
                            child: textField(
                              controller: phoneNumber,
                              context: context,
                              isActive: true,
                              onSubmitted: (value) {
                                if (phoneNumberRegex.hasMatch(
                                  countryCode +
                                      phoneNumber.text
                                          .replaceAll(' ', '')
                                          .trim(),
                                )) {
                                  sendOtpCode();
                                  isActive = false;

                                  isLoading = true;
                                  setState(() {});
                                } else {
                                  errorMessage =
                                      '*Phone number is not in a correct format';
                                }
                              },
                              onTap: () {
                                //isActive = true;

                                setState(() {});
                              },
                              hintText: 'Phone number',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  errorMessage.isNotEmpty
                      ? SizedBox(
                          height: 34.h,
                        )
                      : Container(),
                  errorMessage.isEmpty
                      ? Container()
                      : Text(
                          errorMessage,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.red,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                  SizedBox(
                    height: 34.h,
                  ),
                  SizedBox(
                    width: 314.w,
                    child: primaryButton(
                      onPressed: () async {
                        if (phoneNumberRegex.hasMatch(
                          countryCode +
                              phoneNumber.text.replaceAll(' ', '').trim(),
                        )) {
                          sendOtpCode();
                          isActive = false;

                          isLoading = true;
                          setState(() {});
                        } else {
                          errorMessage =
                              '*Phone number is not in a correct format';
                        }
                      },
                      isLoading: isLoading,
                      label: 'LOGIN',
                      backgroundColor: primaryGreen,
                      size: Size(62.48.w, 60.h),
                    ),
                  ),
                  // secondaryButton(
                  //     label: 'Skip for now',
                  //     onPressed: () {
                  //       getPage(context, const AllScreens());
                  //     }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendOtpCode() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNum = phoneNumber.text.trim();
    //+9647518070601
    phoneNumberOnBoarding = '$countryCode$phoneNum';
    //print(phoneNumberOnBoarding);
    ap.checkExistingPhone(phoneNumberOnBoarding!).then((value) {
      debugPrint(value.toString());
      if (value) {
        errorMessage = 'This phone number is already registered.';
        isLoading = false;
        setState(() {});
      } else {
        ap.signInWithPhone(context, "+$countryCode$phoneNum");
      }
    });
  }
}
