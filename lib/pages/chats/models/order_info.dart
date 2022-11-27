import 'package:brainworld/components/utilities_widgets/mydate_formatter.dart';

class OrderInfo {
  // final String role;

  final String user_id; //owner of course
  final String order_id;
  final String post_id;
  final String current_user_id;
  final String current_user_name;
  final String email;
  final String? phone;
  final String? address;
  final String title;
  final String orderType; //either course or book
  final String? orderOn;
  final String price;

  // final String? profilePhoto;

  OrderInfo({
    required this.user_id,
    required this.order_id,
    required this.post_id,
    required this.current_user_id,
    required this.current_user_name,
    required this.email,
    this.address,
    this.phone,
    required this.title, //title of the course
    required this.orderType, //title of the course
    required this.price,
    this.orderOn,
    // this.profilePhoto
  });
  static OrderInfo fromJson(Map<String, dynamic> json) => OrderInfo(
        order_id: json['order_id'],
        user_id: json['user_id'],
        current_user_id: json['current_user_id'],
        post_id: json['post_id'],
        current_user_name: json['current_user_name'],
        email: json['email'],
        address: json['address'],
        // profilePhoto: json['profilePhotoUrl'],
        phone: json['phone'],
        title: json['title'],
        price: json['price'],
        orderType: json['orderType'],
        orderOn: MyDateFormatter.dateFormatter(
          datetime:
              DateTime.parse(json['orderedOn'] ?? '2022-11-02 19:10:31.998691'),
        ),
      );

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'order_id': order_id,
        'current_user_id': current_user_id,
        'post_id': post_id,
        'orderType': orderType,
        'current_user_name': current_user_name,
        'email': email,
        'phone': phone,
        'address': address,
        'title': title,
        'price': price,
        "orderOn": DateTime.now().toString()
      };
}
