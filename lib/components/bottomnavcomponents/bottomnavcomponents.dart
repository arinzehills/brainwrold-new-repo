import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/pages/books_library/add_to_books.dart';
import 'package:brainworld/pages/upload/add_post.dart';
import 'package:brainworld/pages/upload/add_to_local_library.dart';
import 'package:brainworld/pages/upload/course/upload_course_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget uploadPopUp(_controller) {
  return AnimatedBuilder(
    animation: _controller,
    builder: (context, child) => FadeScaleTransition(
      animation: _controller,
      child: child,
    ),
    child: Visibility(
      visible: _controller.status != AnimationStatus.dismissed,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 15,
                  blurRadius: 17,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upload',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  iconAndCourse(
                      title: 'A Book',
                      icon: 'booksicon.svg',
                      onclick: () {
                        Get.to(AddToBooks());
                      }),
                  iconAndCourse(
                      title: 'A Course',
                      icon: 'gragicon.svg',
                      iconHeight: 31,
                      onclick: () {
                        Get.to(UploadCourseInfo());
                      }),
                  iconAndCourse(
                      title: 'Post',
                      icon: 'posticon.svg',
                      onclick: () {
                        Get.to(AddPost(note_count: 1));
                      })
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget iconAndCourse({title, icon, double? iconHeight, VoidCallback? onclick}) {
  return GestureDetector(
    onTap: onclick,
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
          height: 79,
          width: 86,
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(13, 0, 0, 0)),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xffEAEAEA).withOpacity(0.3)),
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset('assets/svg/$icon',
                  height: iconHeight ?? 21,
                  // fit: BoxFit.fill,
                  color: myhomepageBlue,
                  semanticsLabel: 'A red up arrow'),
              Text(
                title ?? '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )),
    ),
  );
}
