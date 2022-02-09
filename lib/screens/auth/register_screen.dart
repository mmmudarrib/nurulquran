import 'package:flutter/material.dart';
import 'package:nurulquran/database/user_api.dart';
import 'package:nurulquran/models/app_user.dart';
import 'package:nurulquran/services/user_local_data.dart';
import 'package:nurulquran/utilities/custom_validator.dart';
import 'package:nurulquran/utilities/utilities.dart';
import 'package:nurulquran/widgets/circular_icon_button.dart';
import 'package:nurulquran/widgets/custom_textformfield.dart';
import 'package:nurulquran/widgets/custom_toast.dart';
import 'package:nurulquran/widgets/show_loading.dart';

import '../user_screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Register Personal Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    CustomTextFormField(
                      title: 'First Name',
                      hint: 'First Name',
                      controller: _firstName,
                      validator: (String? value) =>
                          CustomValidator.lessThen3(value),
                    ),
                    CustomTextFormField(
                      title: 'Last Name',
                      hint: 'Last Name',
                      controller: _lastName,
                      validator: (String? value) =>
                          CustomValidator.lessThen3(value),
                    ),
                    const SizedBox(height: 20),
                    CircularIconButton(
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          showLoadingDislog(context);

                          final AppUser _appUser = AppUser(
                            uid: UserLocalData.getUID,
                            phoneNumber: UserLocalData.getPhone,
                            name: '${_firstName.text} ${_lastName.text}',
                          );
                          final bool _okay = await UserAPI().addUser(_appUser);
                          UserLocalData().storeAppUserData(appUser: _appUser);
                          if (_okay) {
                            CustomToast.successToast(
                              message: 'Register Successfully',
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
