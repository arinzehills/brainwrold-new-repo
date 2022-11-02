import 'package:brainworld/components/drawer.dart';
import 'package:brainworld/components/my_button.dart';
import 'package:brainworld/components/my_text_field.dart';
import 'package:brainworld/components/normal_curve_container.dart';
import 'package:brainworld/components/utilities_widgets/my_navigate.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/models/user.dart';
import 'package:brainworld/pages/chats/models/posts_model.dart';
import 'package:brainworld/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key, this.totalAmount, this.course}) : super(key: key);
  final String? totalAmount;
  final PostsModel? course;
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final CartService cartController = Get.find();
  late User user;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String phone = '';
  String address = '';
  bool autovalidate = false;
  String error = '';

  @override
  void initState() {
    // userData = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String emailInitialValue = user.email;
    String phoneInitialValue = 'userData.phone';

    return Scaffold(
      drawer: MyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NormalCurveContainer(
                pagetitle: 'CHECKOUT',
                size: size,
                height: size.height * 0.43,
                container_radius: 140,
                widget: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Container(
                    height: size.height * 0.27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: myhomepageBlue.withOpacity(0.9),
                            // spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [myhomepageBlue, myhomepageLightBlue])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageIcon(
                                AssetImage('assets/visa.png'),
                                size: 60,
                                color: Colors.white,
                              ),
                              Text(
                                'Total: ${widget.totalAmount ?? cartController.total}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            '1234 5678 910 1112',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'userData.name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                '11/22',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        hintText: 'Enter your email',
                        initiaiValue: emailInitialValue,
                        autovalidate: true,
                        keyboardType: TextInputType.emailAddress,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required'),
                          EmailValidator(errorText: "Enter a Valid Email")
                        ]),
                        onChanged: (val) {
                          // if (mounted) {
                          //   setState(() => email = val);
                          // }
                          setState(() => phone = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Phone',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        autovalidate: true,
                        hintText: 'Enter your phone number',
                        keyboardType: TextInputType.number,
                        initiaiValue: phoneInitialValue,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required'),
                          MinLengthValidator(11,
                              errorText: 'Enter correct phone number')
                        ]),
                        onChanged: (val) {
                          // if (mounted) {
                          //   setState(() => phone = val);
                          // }
                          setState(() => phone = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        hintText: 'Enter your address',
                        autovalidate: true,
                        onChanged: (val) {
                          if (mounted) {
                            setState(() => address = val);
                          }
                        },
                        validator:
                            RequiredValidator(errorText: 'Address is required'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: MyButton(
                          isGradientButton: true,
                          gradientColors: myblueGradient,
                          placeHolder: 'Continue',
                          pressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
