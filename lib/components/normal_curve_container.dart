import 'package:brainworld/components/my_text_field.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:brainworld/components/drawer.dart';
import 'package:flutter_svg/svg.dart';

class NormalCurveContainer extends StatelessWidget {
  String? pagetitle;
  Widget? widget;
  String? imageUrl;
  String? searchHint;
  double? container_radius;
  bool showDrawer;
  final double height;
  NormalCurveContainer({
    Key? key,
    required this.size,
    this.pagetitle,
    this.widget,
    this.showDrawer = false,
    this.searchHint,
    this.container_radius,
    required this.height,
    this.imageUrl,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(container_radius ?? 110)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: myblueGradient)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (showDrawer)
                    IconButton(
                      onPressed: () => {
                        if (imageUrl == null)
                          {Scaffold.of(context).openDrawer()}
                        else
                          {Navigator.pop(context)}
                      },
                      icon: SvgPicture.asset(
                          imageUrl == null
                              ? 'assets/svg/menuicon.svg'
                              : imageUrl!,
                          // height: 10,
                          // fit: BoxFit.fill,
                          color: Colors.white,
                          semanticsLabel: 'A red up arrow'),
                    ),
                  Text(
                    pagetitle ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0,
            ),
            widget ?? SizedBox(),
          ]),
    );
  }
}
