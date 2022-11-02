import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/pages/chats/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartService extends GetxController {
  var _courses = {}.obs;

  void addCourse(PostsModel course) {
    if (_courses.containsKey(course)) {
      Get.snackbar('Course  already in cart',
          'You have added the ${course.title} to the cart ',
          // "You have added a product with ${course.courseType}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: myhomepageBlue.withOpacity(0.5),
          colorText: Colors.white,
          duration: Duration(seconds: 1));
    } else {
      _courses[course] = 1;

      Get.snackbar('Course added to cart',
          'You have added the ${course.title} to the cart ',
          // "You have added a product with ${course.courseType}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: myhomepageBlue.withOpacity(0.5),
          colorText: Colors.white,
          duration: Duration(milliseconds: 800));
    }
  }

  void removeCourse(PostsModel course) {
    if (_courses.containsKey(course)) {
      _courses.removeWhere((key, value) => key == course);
      Get.snackbar(
          'Course removed', 'You have remove the ${course.title} from cart ',
          // "You have added a product with ${course.courseType}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: myhomepageBlue.withOpacity(0.5),
          colorText: Colors.white,
          duration: Duration(milliseconds: 900));
    }
  }

  void removeAllCourses() {
    _courses.clear();
  }

  get courses => _courses;

  get total => _courses.entries
      .map((course) => int.parse(course.key.price))
      .toList()
      .reduce(
        (value, element) => value + element,
      )
      .toString();
}
