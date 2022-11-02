import 'dart:convert';
import 'package:get/get.dart';

class CourseController extends GetxController {
  var allPost = <CourseReaction>[].obs;
}

class CourseReaction {
  CourseReaction({
    this.post_id,
    this.user_id,
    this.subscribers_id,
    this.comments,
    this.likes,
    this.subscribers,
  });

  String? user_id;
  String? post_id;
  String? subscribers_id;
  List<dynamic>? likes = [];
  List<dynamic>? comments = [];
  List<dynamic>? subscribers = [];

  factory CourseReaction.fromJson(Map<String, dynamic> json) => CourseReaction(
        user_id: json["user_id"],
        subscribers_id: json["subscribers_id"],
        post_id: json["_id"],
        subscribers: json["subscribers"],
        likes: json["likes"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "post_id": post_id,
        "subscribers_id": subscribers_id,
        "likes": likes,
        "comments": comments,
        "subscribers": subscribers,
      };
}
