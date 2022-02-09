import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nurulquran/database/user_api.dart';
import 'package:nurulquran/models/app_user.dart';
import 'package:nurulquran/screens/admin_screens/admin_dashboard.dart';
import 'package:nurulquran/services/user_local_data.dart';
import 'package:nurulquran/utilities/custom_validator.dart';
import 'package:nurulquran/widgets/custom_text_button.dart';
import 'package:nurulquran/widgets/custom_textformfield.dart';
import 'package:nurulquran/widgets/phone_number_field.dart';
import '../../utilities/custom_image.dart';
import '../../utilities/utilities.dart';
import '../../widgets/circular_icon_button.dart';
import '../user_screens/home_screen.dart';
import 'register_screen.dart';

enum MobileVerificationState {
  showMobileFormState,
  showOtpFormState,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.showMobileFormState;
  String phone = "";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";
  bool showLoading = false;
  final otpController = TextEditingController();

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        bool exist = await UserAPI().getexists(uid: authCredential.user!.uid);
        UserLocalData.setUID(authCredential.user!.uid);
        UserLocalData.setPhone(phone);
        if (exist) {
          AppUser user = await UserAPI().getInfo(uid: authCredential.user!.uid);
          UserLocalData().storeAppUserData(appUser: user);
          if (UserLocalData.getIsAdmin) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminDashboard()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterScreen(),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  SingleChildScrollView getMobileFormWidget(
      BuildContext context, double height, double width) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Utilities.padding),
      child: Form(
        key: _key,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.036),
              SizedBox(
                width: width * 0.60,
                height: height * 0.30,
                child: Padding(
                  padding: EdgeInsets.all(Utilities.padding * 2),
                  child: Image.asset(CustomImages.logo),
                ),
              ),
              Text(
                "Login",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.026),
              const Text(
                "Enter your phone number to login or create account",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.036),
              PhoneNumberField(
                onChange: (p0) {
                  setState(() {
                    phone = p0.completeNumber;
                  });
                },
              ),
              CircularIconButton(
                onTap: () async {
                  setState(() {
                    showLoading = true;
                  });

                  await _auth.verifyPhoneNumber(
                    phoneNumber: phone,
                    verificationCompleted: (phoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });
                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    verificationFailed: (verificationFailed) async {
                      setState(() {
                        showLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(verificationFailed.message!)));
                    },
                    codeSent: (verificationId, resendingToken) async {
                      setState(() {
                        showLoading = false;
                        currentState = MobileVerificationState.showOtpFormState;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getOtpFormWidget(BuildContext context, double height, double width) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Utilities.padding),
      child: Form(
        key: _key,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.036),
              SizedBox(
                width: width * 0.60,
                height: height * 0.30,
                child: Padding(
                  padding: EdgeInsets.all(Utilities.padding * 2),
                  child: Image.asset(CustomImages.logo),
                ),
              ),
              Text(
                "Verify the OTP",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.026),
              const Text(
                "Enter OTP you recieved",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.036),
              CustomTextFormField(
                controller: otpController,
                hint: "123456",
                title: "OTP",
                keyboardType: TextInputType.number,
                validator: (value) => CustomValidator.otp(value),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextButton(
                onTap: () async {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);

                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                text: "VERIFY",
                hollowButton: false,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      child: showLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : currentState == MobileVerificationState.showMobileFormState
              ? getMobileFormWidget(context, height, width)
              : getOtpFormWidget(context, height, width),
      padding: const EdgeInsets.all(16),
    ));
  }
}
