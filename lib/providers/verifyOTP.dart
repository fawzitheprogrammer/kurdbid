import 'package:kurdbid/components/colors.dart';
import 'package:kurdbid/public_packages.dart';

class VerifyOTP extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  //final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  Color errorBorder = backgroundGrey1;

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        errorBorder = primaryGreen;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorBorder = Colors.redAccent;
      //showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }

    // Future.delayed(Duration(seconds: 4)).then((value) {
    //  // _codeNotCorrect = false;
    //   notifyListeners();
    //   debugPrint('EXECUTED----------------');
    // });
  }
}
