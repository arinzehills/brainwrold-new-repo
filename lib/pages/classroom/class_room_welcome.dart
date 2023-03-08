import 'package:brainworld/components/drawer.dart';
import 'package:brainworld/components/my_button.dart';
import 'package:brainworld/components/normal_curve_container.dart';
import 'package:brainworld/components/nothing_yet_widget.dart';
import 'package:brainworld/components/utilities_widgets/my_navigate.dart';
import 'package:brainworld/constants/api_utils_constants.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/models/user.dart';
import 'package:brainworld/pages/chats/models/isnewuser_data_model.dart';
import 'package:brainworld/pages/classroom/start_new_class.dart';
import 'package:brainworld/pages/upload/add_to_local_library.dart';
import 'package:brainworld/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'join_class.dart';

class ClassRoomWelcome extends StatefulWidget {
  const ClassRoomWelcome({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassRoomWelcome> createState() => _ClassRoomWelcomeState();
}

class _ClassRoomWelcomeState extends State<ClassRoomWelcome> {
  late IsNewUserModel userInfoData;
  bool showIntroPage = true;
  @override
  void initState() {
    super.initState();
    _getUserRegInfo();

    // var index = widget.index;
  }

  _getUserRegInfo() async {
    var userInfo = await getUserRegInfo();
    if (this.mounted) {
      setState(() {
        userInfoData = IsNewUserModel.fromJson(userInfo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);

    return Scaffold(
      drawer: MyDrawer(),
      body: showIntroPage && userInfoData.classRoom == true
          ? NothingYetWidget(
              pageTitle: 'WELCOME TO BRAINWORLD LECTURE THEATRE',
              pageHeader: "CLASS ROOM",
              imageURL: 'manwithpc.png',
              pageContentText:
                  'Welcome to Brain world class room you can fix \n'
                  'class dicussions,lectures,virtual meetings, group discussion and conferences here.\n',
              onClick: () async {
                var userModel = IsNewUserModel(
                    id: user.id,
                    username: user.full_name,
                    newlyRegistered: true,
                    bookLib: userInfoData.bookLib == false ? false : true,
                    library: userInfoData.library == false ? false : true,
                    lab: userInfoData.lab == false ? false : true,
                    classRoom: true,
                    chat: userInfoData.chat == false ? false : true,
                    regAt: 'regAt');
                AuthService.setIsNewUser(userModel);
                setState(() => {showIntroPage = false});
                // MyNavigate.navigatejustpush(AddToBooks(), context);
              },
            )
          : Column(
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
                          ImageIcon(
                            AssetImage('assets/images/uploads_blue.png'),
                            size: 46,
                            color: Colors.white,
                          ),
                          Text(
                            'Start or Join a class',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.091,
                ),
                Image.asset(
                  "assets/images/student.png",
                  height: 240,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.to(JoinAClass());
                  },
                  child: Text(
                    'Join Classroom',
                    style: TextStyle(
                        color: myhomepageBlue.withOpacity(0.7),
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(
                  placeHolder: 'Start new class',
                  height: 55,
                  isGradientButton: true,
                  isOval: true,
                  gradientColors: myblueGradientTransparent,
                  widthRatio: 0.80,
                  pressed: () async {
                    Get.to(StartNewClass());
                  },
                ),
              ],
            ),
    );
  }
}
