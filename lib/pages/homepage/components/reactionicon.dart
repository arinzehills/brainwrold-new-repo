import 'package:brainworld/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReactionIcon extends StatelessWidget {
  String iconUrl;
  double? iconHeight;
  bool? withMarginLeft;
  String? text;
  final VoidCallback onClick;

  ReactionIcon({
    Key? key,
    required this.onClick,
    required this.iconUrl,
    this.text,
    this.withMarginLeft = false,
    this.iconHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: withMarginLeft! ? 10 : 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onClick,
            child: SvgPicture.asset(iconUrl,
                height: iconHeight ?? 21,
                // fit: BoxFit.fill,
                color: myhomepageBlue,
                semanticsLabel: 'A red up arrow'),
          ),
          Text(text ?? ''),
        ],
      ),
    );
  }
}
