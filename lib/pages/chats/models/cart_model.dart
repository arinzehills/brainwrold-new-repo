import 'dart:convert';

import 'dart:io';

import 'package:brainworld/components/utilities_widgets/mydate_formatter.dart';

CartModel chatModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String chatModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    required this.user_id, //id of the person who made the post or has the book
    this.current_user_id,
    required this.post_id,
    required this.title,
    required this.price,
    required this.postType,
    this.imageUrl,
    this.orderedOn,
  });

  String user_id; //this is the user that made the post
  String? current_user_id; //this is the user placing order
  String? post_id;
  String title;
  String price;
  String postType; //either course or book
  String? imageUrl;
  String? orderedOn;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        user_id: json["user_id"],
        current_user_id: json["current_user_id"],
        post_id: json["post_id"],
        title: json["title"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        postType: json["postType"],
        orderedOn: MyDateFormatter.dateFormatter(
          datetime:
              DateTime.parse(json['orderedOn'] ?? '2022-11-02 19:10:31.998691'),
        ),
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "current_user_id": current_user_id,
        "post_id": post_id,
        "title": title,
        "price": price,
        "imageUrl": imageUrl,
        "orderedOn": DateTime.now().toString(),
        "postType": postType,
      };
}
