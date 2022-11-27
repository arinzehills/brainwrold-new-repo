import 'package:brainworld/components/bottomnavcomponents/bottomnavcomponents.dart';
import 'package:brainworld/components/utilities_widgets/radial-gradient.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/controllers/chat_controller.dart';
import 'package:brainworld/pages/books_library/books_library.dart';
import 'package:brainworld/pages/chats/chat.dart';
import 'package:brainworld/pages/homepage.dart';
import 'package:brainworld/pages/laboratory/laboratory.dart';
import 'package:brainworld/pages/library/library.dart';
import 'package:brainworld/pages/library/user_library.dart';
import 'package:brainworld/pages/library/welcome/library_welcome.dart';
import 'package:brainworld/pages/purchased/purchased.dart';
import 'package:brainworld/pages/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BottomNavigation extends StatefulWidget {
  final int? index;

  const BottomNavigation({Key? key, this.index}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  late Socket socket;
  ChatController chatUsersListController = ChatController();

  final PageStorageBucket _bucket = PageStorageBucket();
  late AnimationController _popup_animation_controller;
  bool get isForwardAnimation =>
      _popup_animation_controller.status == AnimationStatus.forward ||
      _popup_animation_controller.status == AnimationStatus.completed;
  late int _selectedIndex = widget.index ?? 0;
  bool showuploadPopup = false;

  @override
  void initState() {
    _popup_animation_controller = AnimationController(
      value: 0,
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 1000),
      vsync: this,
    )..addStatusListener((status) => {setState(() {})});
  }

  @override
  void dispose() {
    _popup_animation_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      MyHomePage(
        title: 'Home',
      ),
      // Purchased(),
      Library(),
      Chat(
          // chatUsersListController: chatUsersListController,
          ),
      Laboratory(),
      BooksLibrary(),
      Profile(),
    ];
    return Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: Stack(
            children: [
              pages[_selectedIndex],
              showuploadPopup
                  ? Positioned(
                      bottom: 40,
                      left: size(context).width * 0.1,
                      child: uploadPopUp(_popup_animation_controller))
                  : SizedBox(),
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 5,
              child: Container(
                  height: 60,
                  decoration:
                      BoxDecoration(color: myhomepageBlue.withOpacity(0.07)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bottomNavIcon(
                            number: 0,
                            name: 'Home',
                          ),
                          bottomNavIcon(
                              name: 'Library',
                              number: 1,
                              svgImage: 'assets/svg/libraryicon.svg'),
                          bottomNavIcon(
                              name: 'Chats',
                              number: 2,
                              svgImage: 'assets/svg/chatsbubble.svg'),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bottomNavIcon(
                              name: 'Lab',
                              number: 3,
                              svgImage: 'assets/svg/laboratory.svg'),
                          bottomNavIcon(
                              name: 'Books',
                              number: 4,
                              svgImage: 'assets/svg/booksicon.svg'),
                          bottomNavIcon(
                              name: 'Profile',
                              number: 5,
                              svgImage: 'assets/svg/profileicon.svg'),
                        ],
                      ),
                    ],
                  ))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            isForwardAnimation
                ? _popup_animation_controller.reverse()
                : _popup_animation_controller.forward();
            setState(() {
              showuploadPopup = !showuploadPopup;
            });
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => CreateRecord()));
          },
          backgroundColor: Colors.transparent,
          child: Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(15),
            child: SvgPicture.asset(
                !showuploadPopup
                    ? 'assets/svg/uploadicon.svg'
                    : 'assets/svg/arrowdown.svg',
                height: 20,
                fit: BoxFit.scaleDown,
                color: Colors.white,
                semanticsLabel: 'A red up arrow'),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: myblueGradientTransparent)),
          ),
        ));
  }

  MaterialButton bottomNavIcon({
    name,
    number,
    svgImage,
  }) {
    return MaterialButton(
        minWidth: 20,
        onPressed: () {
          setState(() {
            _selectedIndex = number;
          });
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RadiantGradientMask(
            isGrey: _selectedIndex == number ? false : true,
            child: SvgPicture.asset(svgImage ?? 'assets/svg/homeicon.svg',
                height: 20,
                fit: BoxFit.fill,
                color: iconsColor,
                semanticsLabel: 'A red up arrow'),
          ),
          _selectedIndex == number
              ? Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(name,
                      style: TextStyle(
                        color:
                            _selectedIndex == 0 ? myhomepageBlue : Colors.grey,
                      )),
                )
              : SizedBox()
        ]));
  }
}
