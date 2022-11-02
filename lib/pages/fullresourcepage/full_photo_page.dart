import 'package:brainworld/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;
  final String? pageTitle;

  FullPhotoPage({Key? key, required this.url, this.pageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myhomepageBlue,
        title: Text(
          pageTitle ?? 'Full Photo',
          style: TextStyle(color: myhomepageLightBlue),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
