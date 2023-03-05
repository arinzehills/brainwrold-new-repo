import 'dart:convert';

import 'package:brainworld/components/bottomnavigation.dart';
import 'package:brainworld/components/my_button.dart';
import 'package:brainworld/components/my_text_field.dart';
import 'package:brainworld/components/no_account.dart';
import 'package:brainworld/components/utilities_widgets/loading.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/pages/auth_screens/register.dart';
import 'package:brainworld/pages/getstarted_page.dart';
import 'package:brainworld/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool obscureText = false;
  String email = '';

  String password = '';
  bool autovalidate = false;
  String error = '';
  bool loading = false;

  Future<bool> _onBackPressed() {
    return Navigator.of(context)
        .push(
          MaterialPageRoute(builder: (context) => GetStartedPage()),
        )
        .then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                      // overflow: Overflow.visible,
                      clipBehavior: Clip.antiAlias,
                      children: [
                        Positioned(
                          top: -13,
                          right: 0,
                          child: SvgPicture.asset(
                            'assets/svg/upcurve.svg',
                            // height: 320,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -20,
                          child: SvgPicture.asset(
                            'assets/svg/downcurve.svg',
                            width: MediaQuery.of(context).size.width + 20,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 139.0, left: 11),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 21, 255),
                                      fontSize: 43,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 10.0, top: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildText(text: 'Email'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      hintText: 'Enter your email',
                                      autovalidate: autovalidate,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (val) {
                                        if (mounted) {
                                          setState(() => email = val);
                                        }
                                      },
                                      onTap: () {
                                        if (autovalidate == true) {
                                          setState(() {
                                            autovalidate = false;
                                          });
                                        } else {
                                          setState(() {
                                            autovalidate = true;
                                          });
                                        }
                                      },
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Required'),
                                        EmailValidator(
                                            errorText: "Enter a Valid Email")
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    buildText(text: 'Password'),
                                    MyTextField(
                                      hintText: 'Enter password',
                                      autovalidate: autovalidate,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      onChanged: (val) {
                                        if (mounted) {
                                          setState(() => password = val);
                                        }
                                      },
                                      onTap: () {
                                        if (autovalidate == true) {
                                          setState(() {
                                            autovalidate = false;
                                          });
                                        } else {
                                          setState(() {
                                            autovalidate = true;
                                          });
                                        }
                                      },
                                      obscureText: obscureText,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Required'),
                                        MinLengthValidator(3,
                                            errorText:
                                                'Password must be at least 3 character long'),
                                      ]),
                                      suffixIconButton: IconButton(
                                        icon: const Icon(Icons.visibility),
                                        color: myhomepageBlue,
                                        onPressed: () {
                                          if (obscureText == true) {
                                            setState(() {
                                              obscureText = false;
                                            });
                                          } else {
                                            setState(() {
                                              obscureText = true;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      error,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: MyButton(
                                        placeHolder: 'SIGN IN',
                                        isGradientButton: true,
                                        isOval: true,
                                        gradientColors:
                                            myOrangeGradientTransparent,
                                        widthRatio: 0.45,
                                        pressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() => loading = true);
                                            var response = await AuthService()
                                                .login(email, password);
                                            // print(response['success']);
                                            if (response['success'] == true) {
                                              setState(() => {});
                                              snackBar(
                                                  BottomNavigation(),
                                                  context,
                                                  'Logged in successfully');
                                            } else {
                                              setState(() => loading = false);
                                              setState(() =>
                                                  error = response['message']);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    NoAccount(
                                      title: 'Already have an account?',
                                      subtitle: 'REGISTER',
                                      pressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Register()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ])),
            ),
          );
  }

  Text buildText({text}) => Text(
        text,
        style: TextStyle(
          color: myhomepageBlue,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      );
}
