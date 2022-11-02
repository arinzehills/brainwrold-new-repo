import 'package:brainworld/components/my_button.dart';
import 'package:brainworld/components/utilities_widgets/gradient_text.dart';
import 'package:brainworld/components/utilities_widgets/my_navigate.dart';
import 'package:brainworld/components/utilities_widgets/radial-gradient.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/pages/checkout/checkout.dart';
import 'package:brainworld/services/cart_service.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void showCartBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Container(child: MyCartWidget());
      });
}

class MyCartWidget extends StatefulWidget {
  const MyCartWidget({
    Key? key,
    // required this.imgUrl,
  }) : super(key: key);

  // final List<String> imgUrl;

  @override
  State<MyCartWidget> createState() => _MyCartWidgetState();
}

class _MyCartWidgetState extends State<MyCartWidget> {
  @override
  Widget build(BuildContext context) {
    final CartService cartController = Get.find();

    // print(courses.price);
    return Obx(
      () => Stack(
        children: [
          cartController.courses.length != 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 35.0, bottom: 80),
                  child: ListView.builder(
                      itemCount: cartController.courses.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      //  padding: EdgeInsets.only(top: 10,bottom: 10),
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final courses = cartController.courses.keys.toList();
                        return Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10, bottom: 10),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 30,
                                        spreadRadius: 0,
                                        offset: Offset(5, 20))
                                  ]),
                              child: Column(
                                children: [
                                  Row(
                                      //the whole row of the container
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          //the row that container the image and the name
                                          children: [
                                            ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                child: Image.asset(
                                                  "assets/sciences.png",
                                                  height: 70,
                                                )),
                                            Column(
                                              children: [
                                                Text(
                                                  courses[index].courseTitle,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(//for name of author
                                                    children: [
                                                  Icon(
                                                    Icons.person,
                                                    color: Colors.grey,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    'admin',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey),
                                                  ),
                                                ]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cartController
                                                .removeCourse(courses[index]);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Remove',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0),
                                          child: Text(
                                            'NGN ' + courses[index].price,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: GradientText('Your cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  gradient: LinearGradient(
                                    colors: [
                                      myhomepageBlue,
                                      myhomepageLightBlue
                                    ],
                                  ))),
                          RadiantGradientMask(
                            child: IconButton(
                              icon: Icon(
                                //  Icons.cabin,
                                Icons.cancel_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No Items in cart',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              RadiantGradientMask(
                                child: IconButton(
                                  icon: Icon(
                                    //  Icons.cabin,
                                    Icons.cabin,
                                    color: Colors.blue,
                                    size: 80,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
          //the header of the cart
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 13.0),
                      child: GradientText(
                          'Your cart(${cartController.courses.length})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          gradient: LinearGradient(
                            colors: [myhomepageBlue, myhomepageLightBlue],
                          ))),
                  SizedBox(
                    width: 60,
                  ),
                  OutlineButton(
                    color: myhomepageBlue,
                    disabledBorderColor: myhomepageBlue,
                    borderSide: BorderSide(color: myhomepageBlue),
                    onPressed: () {
                      cartController.removeAllCourses();
                    },
                    child: Text(
                      'Empty cart',
                      style: TextStyle(color: myhomepageBlue),
                    ),
                  ),
                  RadiantGradientMask(
                    child: IconButton(
                      icon: Icon(
                        //  Icons.cabin,
                        Icons.cancel_outlined,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          //checkout widget
          if (cartController.courses.length != 0)
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  height: 75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            spreadRadius: 0,
                            offset: Offset(5, 20)),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [myhomepageLightBlue, myhomepageBlue])),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'NGN ${cartController.total}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 6),
                        child: MyButton(
                          placeHolder: 'Checkout',
                          pressed: () {
                            MyNavigate.navigatejustpush(Checkout(), context);
                          },
                          isGradientButton: true,
                          gradientColors: [myhomepageLightBlue, myhomepageBlue],
                        ),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
