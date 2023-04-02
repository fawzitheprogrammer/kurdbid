import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kurdbid/components/components_barrel.dart';
import 'package:kurdbid/no_network.dart';
import 'package:kurdbid/providers/appointment_provider.dart';
import 'package:kurdbid/providers/auth_provider.dart';
import 'package:kurdbid/providers/bottom_narbar_provider.dart';
import 'package:kurdbid/providers/fetch_data_from_firebase.dart';
import 'package:kurdbid/providers/network_providers.dart';
import 'package:kurdbid/providers/verifyOTP.dart';
import 'package:kurdbid/public_packages.dart';
import 'package:kurdbid/shared_preferences/role.dart';
import 'package:kurdbid/shared_preferences/shared_pref_barrel.dart';
import 'package:kurdbid/theme/theme_style.dart';
import 'package:kurdbid/user_screens/screen_tobe_shown.dart';
import 'providers/theme_provider.dart';
import 'user_screens/screens_barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: primaryGreen, systemNavigationBarColor: primaryGreen),
  );

  await ScreenStateManager.init();
  // await ScreenStateManager.init();
  await Role.init();

  runApp(MyApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //bool isConnected = true;

  List<Widget> noNet = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    Future.delayed(const Duration(seconds: 5))
        .then((value) => checkConnection().then((value) {
              //print(value);
              if (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppRouter.getPage(),
                  ),
                );
              } else {
                Future.delayed(const Duration(seconds: 5));
                noNet = [
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
                          load();
                        },
                        label: 'Reload',
                        backgroundColor: primaryGreen,
                        size: Size(120.w, 50.h),
                      )
                    ],
                  )
                ];
                setState(() {});
              }
            }));
  }

  Future<bool> checkConnection() async {
    bool isConnected = true;

    //
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      isConnected = true;
      //print(isConnected);
      //notifyListeners();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
      //print(isConnected);
      //notifyListeners();
    } else {
      isConnected = false;
      //print(isConnected);
      //notifyListeners();
    }

    return isConnected;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                getImage(folderName: 'images', fileName: 'bg.png'),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: noNet.isEmpty
                ? [
                    const Spacer(),
                    textLabel(
                        text: 'Welcome to KURDbid',
                        color: backgroundGrey1,
                        fontSize: 22.sp),
                    Padding(
                      padding: EdgeInsets.only(bottom: 44.h, top: 10.h),
                      child: SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CircularProgressIndicator(
                          color: backgroundGrey1,
                        ),
                      ),
                    ),
                    // : Container()
                  ]
                : noNet,
          ),
        ),
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

//
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavBar(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Network(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppointmentProvider(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          final provider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            themeMode: provider.themeMode,
            debugShowCheckedModeBanner: false,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            home: SplashScreen(),
          );
        },
        designSize: const Size(430, 932),
        minTextAdapt: true,
      ),
    );
  }
}

class AllScreens extends StatelessWidget {
  const AllScreens({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex =
        Provider.of<BottomNavBar>(context, listen: true).currentIndex;
    final provider = Provider.of<BottomNavBar>(context, listen: false);
    final netwotk = Provider.of<Network>(context, listen: false);

    netwotk.checkConnection();
    //print(netwotk.isConnected);

    return netwotk.isConnected
        ? Scaffold(
            body: PageView(
                //: currentIndex,
                controller: provider.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const HomeScreen(),
                  CateGoryScreen(),
                  const AddItem(),
                  const SettingsScreen(),
                  const ProfileScreen(),
                ]),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                provider.bottomNavIndex(value);
                provider.animateToPage(provider.pageController);
              },
              currentIndex: currentIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: primaryGreen,
              unselectedItemColor: midGrey2,
              selectedLabelStyle: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.onPrimary,
                //fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.onPrimary,
                //fontWeight: FontWeight.w600,
              ),
              type: BottomNavigationBarType.fixed,
              items: [
                navBarItem(
                  label: 'Home',
                  activeIconName: 'home.svg',
                  inActiveIconName: 'home_filled.svg',
                ),
                navBarItem(
                    label: 'Gavel',
                    activeIconName: 'gavel_outlined.svg',
                    inActiveIconName: 'gavel_filled.svg'),
                navBarItem(
                    label: '',
                    activeIconName: 'add.svg',
                    inActiveIconName: 'add.svg',
                    index: 2),
                navBarItem(
                    label: 'Settings',
                    activeIconName: 'settings_outlined.svg',
                    inActiveIconName: 'settings_filled.svg'),
                navBarItem(
                  label: 'Profile',
                  activeIconName: 'user_outlined.svg',
                  inActiveIconName: 'user_filled.svg',
                ),
              ],
            ),
          )
        : const NoNetwork();
  }

  navBarItem(
      {required String label,
      required String activeIconName,
      required String inActiveIconName,
      int? index}) {
    return BottomNavigationBarItem(
      label: '',
      icon: Padding(
        padding: EdgeInsets.all(3.0.w),
        child: SvgPicture.asset(
          getImage(folderName: 'icons', fileName: activeIconName),
          //width: index == 2 || label == 'Gavel' ? 42 : 22,
          height: index == 2
              ? 32
              : label != 'Gavel'
                  ? 22
                  : 27,
          color: index == 2 ? primaryGreen : midGrey2.withAlpha(80),
        ),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.all(3.0.w),
        child: SvgPicture.asset(
          getImage(folderName: 'icons', fileName: inActiveIconName),
          //width: index == 2 || label == 'Gavel' ? 32 : 22,
          height: index == 2
              ? 32
              : label != 'Gavel'
                  ? 22
                  : 27,
          color: primaryGreen,
        ),
      ),
    );
  }
}
