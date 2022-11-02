import 'dart:convert';

import 'dart:io';

import 'package:brainworld/components/utilities_widgets/mydate_formatter.dart';

PostsModel chatModelFromJson(String str) =>
    PostsModel.fromJson(json.decode(str));

String chatModelToJson(PostsModel data) => json.encode(data.toJson());

class PostsModel {
  PostsModel({
    this.post_id,
    this.user_id,
    this.price,
    this.image,
    this.imageUrl,
    this.videoURL,
    this.title,
    this.postType,
    this.caption,
    this.requirements,
    this.category,
    this.postedOn,
    this.likes,
    this.comments,
    this.subTitles = const [],
    this.fileUrls,
    this.videoUrls,
  });

  String? user_id;
  String? post_id;
  String? title;
  String? price;
  String? caption;
  final String? requirements;
  final String? videoURL; //description video url

  String? postType;
  String? category;
  File? image;
  String? imageUrl;
  String? postedOn;
  final List<String> subTitles; //they are 14
  List<dynamic>? likes = [];
  List<dynamic>? comments = [];
  final List? fileUrls;
  final List? videoUrls;

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        user_id: json["user_id"],
        post_id: json["_id"],
        price: json["price"],
        // image: json["image"],
        imageUrl: json["image"],
        videoURL: json['video'],
        caption: json["caption"],
        postType: json["postType"],
        category: json["caption"],
        title: json["title"],
        postedOn: MyDateFormatter.dateFormatter(
            datetime: DateTime.parse(json['postedOn']), showHours: true),
        likes: json["likes"],
        comments: json["comments"],
        fileUrls: json["fileUrls"],
        videoUrls: json["videoUrls"],
        subTitles: json["subTitles"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "images": image,
        "postedOn": postedOn,
        "caption": caption,
        "postType": postType,
        "category": category,
        "likes": likes,
        "comments": comments,
        "title": title
      };
}
