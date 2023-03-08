import 'dart:math';

import 'package:brainworld/components/drawer.dart';
import 'package:brainworld/components/my_button.dart';
import 'package:brainworld/components/my_text_field.dart';
import 'package:brainworld/components/normal_curve_container.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/pages/upload/add_to_local_library.dart';
import 'package:brainworld/utils/jitsi_meet_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class StartNewClass extends StatefulWidget {
  const StartNewClass({
    Key? key,
  }) : super(key: key);

  @override
  State<StartNewClass> createState() => _StartNewClassState();
}

class _StartNewClassState extends State<StartNewClass> {
  final JitsiMeetMethods _jitsiMeet = JitsiMeetMethods();
  String password = '';
  String meetingCode = '';

  @override
  void initState() {
    var random = Random();
    String _meetingCode = (random.nextInt(10000000) + 10000000).toString();
    // final _meetingCode = Random().toString();

    setState(() {
      meetingCode = 'BrainWorld$_meetingCode';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool autovalidate = false;

    return Scaffold(
      drawer: MyDrawer(),
      body: Column(
        children: [
          NormalCurveContainer(
            size: size,
            height: size.height * 0.21,
            // showDrawer: true,
            container_radius: 90,
            // pagetitle: '2',
            widget: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Start new class',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Image.asset(
            "assets/images/picture.png",
            height: 240,
            width: 220,
          ),
          // Padding(
          //   padding: EdgeInsets.all(14).copyWith(bottom: 1),
          //   child: MyTextField(
          //     hintText: 'Enter Meeting code',
          //     autovalidate: autovalidate,
          //     keyboardType: TextInputType.visiblePassword,
          //     onChanged: (val) {
          //       if (mounted) {
          //         setState(() => password = val);
          //       }
          //     },
          //     onTap: () {
          //       if (autovalidate == true) {
          //         setState(() {
          //           autovalidate = false;
          //         });
          //       } else {
          //         setState(() {
          //           autovalidate = true;
          //         });
          //       }
          //     },
          //     validator: MultiValidator([
          //       RequiredValidator(errorText: 'Required'),
          //       MinLengthValidator(6,
          //           errorText: 'Password must be at least 6 character long'),
          //     ]),
          //     suffixIconButton: IconButton(
          //       icon: const Icon(Icons.copy),
          //       color: myhomepageBlue,
          //       onPressed: () {},
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextButton(
                style: TextButton.styleFrom(
                    // surfaceTintColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 18),
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: meetingCode)).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Meeting code copied!")));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$meetingCode'),
                    Icon(Icons.copy),
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          ),
          MyButton(
            placeHolder: 'Start new class',
            height: 55,
            isGradientButton: true,
            isOval: true,
            gradientColors: myblueGradientTransparent,
            widthRatio: 0.80,
            pressed: () async {
              // Get.to(AddToLocalLibray());
              _jitsiMeet.createMeeting(
                  roomName: meetingCode,
                  isAudioMuted: true,
                  isVideoMuted: true);
            },
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: Text(
          //     'Share link',
          //     style: TextStyle(
          //         color: myhomepageBlue.withOpacity(0.7),
          //         fontSize: 22,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
        ],
      ),
    );
  }
}
