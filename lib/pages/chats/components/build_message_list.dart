import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/pages/chats/models/message.dart';
import 'package:flutter/material.dart';

class BuildMessageList extends StatefulWidget {
  List<UsersMessage> messages;
  int itemCount;
  String sendersid;
  BuildMessageList(
      {Key? key,
      required this.messages,
      required this.sendersid,
      required this.itemCount})
      : super(key: key);

  @override
  State<BuildMessageList> createState() => _BuildMessageListState();
}

class _BuildMessageListState extends State<BuildMessageList> {
  int _limit = 20;
  int _limitIncrement = 20;
  Map<int, bool> showTime = {};

  final ScrollController listScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= widget.messages.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 98.0),
      child: ListView.builder(
          itemCount: widget.itemCount,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: listScrollController,
          reverse: true,
          itemBuilder: (context, index) {
            return buildMessageContainer(index);
          }),
    );
  }

  Widget buildMessageContainer(int index) {
    bool isUser = widget.messages[index].sendersid == widget.sendersid;
    return GestureDetector(
      onTap: () => setState(() => {
            showTime[index] == true
                ? showTime[index] = false
                : showTime[index] = true
          }),
      child: Container(
          padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: (isUser ? buildSender(index) : buildReciever(index))),
    );
  }

  Widget buildSender(index) => Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff2255FF),
                        Color(0xff1477FF).withOpacity(0.9),
                      ]),
                  color: Colors.white),
              child: Text(
                widget.messages[index].messageText,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            showTime[index] == true
                ? Text(widget.messages[index].sentAt.toString())
                : SizedBox(),
          ],
        ),
      );
  Widget buildReciever(index) => Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
              child: Text(
                widget.messages[index].messageText,
                style: TextStyle(fontSize: 15, color: Color(0xff9B9B9B)),
              ),
            ),
            showTime[index] == true
                ? Text(widget.messages[index].sentAt.toString())
                : SizedBox(),
          ],
        ),
      );
}
