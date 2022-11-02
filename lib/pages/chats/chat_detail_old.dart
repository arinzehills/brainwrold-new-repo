import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/controllers/chat_controller.dart';
import 'package:brainworld/pages/chats/components/build_message_list.dart';
import 'package:brainworld/pages/chats/components/chat_icon_gradient.dart';
import 'package:brainworld/pages/chats/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconly/iconly.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatDetail extends StatefulWidget {
  final String sendersid;
  final String clickeduserid;
  final String senderEmail;
  final String clickedEmail;
  //this is  identifies the user that u click to view his chat
  final String? name;
  const ChatDetail(
      {Key? key,
      required this.clickeduserid,
      required this.sendersid,
      required this.clickedEmail,
      required this.senderEmail,
      this.name})
      : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  bool showimg = false;
  String message = '';
  String groupChatId = '';
  final _controller = TextEditingController();
  ChatController chatController = ChatController();
  List<UsersMessage> userMessage = [
    UsersMessage(
      name: "Jorge Henry",
      messageText: "Hey where are you?",
      imageURL: "assets/uploads_blue.png",
      // createdAt: "31 Mar",
      sendersid: 'him',
    ),
    UsersMessage(
      name: "Andrey Jones",
      messageText: "Can you please share the file?",
      imageURL: "assets/uploads_blue.png",
      // createdAt: "24 Feb",
      sendersid: 'me',
    ),
  ];

  late Socket socket;
  var chats;
  @override
  void initState() {
    readLocal();
    socketServer();
    Future.delayed(Duration(microseconds: 2));

    socket.emit('sendMessage', {
      {'chatID': groupChatId, "data": null}
    });
    setupSocketListener();
    super.initState();
  }

  @override
  void dispose() {
    socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('chatController.chatMessages.length');
    print(message);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(105, 237, 235, 235)),
                    child: Center(
                      child: Icon(
                        IconlyBold.arrow_left,
                        color: iconsColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                showimg
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          'widget.imgUrl!',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, object, stackTrace) {
                            return ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                child: Image.asset(
                                  "assets/images/green native.png",
                                  height: 50,
                                ));
                          },
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(
                          "assets/images/green native.png",
                          height: 50,
                        )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name ?? '',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online now",
                        style:
                            TextStyle(color: Color(0xff18DE4E), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(IconlyBold.call, color: iconsColor),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  IconlyBold.video,
                  color: iconsColor,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(children: [
        // Obx(
        //   () => BuildMessageList(
        //     itemCount: chatController.chatMessages.length,
        //     messages: chatController.chatMessages,
        //     sendersid: widget.sendersid,
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 100,
            width: double.infinity,
            color: Color.fromARGB(255, 224, 230, 250),
            child: Row(
              children: <Widget>[
                ChatIconGradient(
                  pressed: () {},
                  iconName: Icons.add,
                  bgColor: myblueGradientTransparent,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    IconlyBold.voice,
                    color: iconsColor,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    // controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Color(0xffC9C4C4)),
                        border: InputBorder.none),
                    onTap: () {},
                    onChanged: (value) => setState(() {
                      message = value;
                    }),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                ChatIconGradient(
                    pressed: message == ''
                        ? null
                        : () => {
                              sendMessage(message.trim()),
                              setState(() {
                                message = '';
                              })
                            },
                    iconName: IconlyBold.send,
                    iconSize: 30,
                    bgHeight: 60,
                    bgColor: myOrangeGradientTransparent),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void socketServer() {
    try {
      // socket = io(
      //     generalUrl,
      //     OptionBuilder()
      //         .setTransports(['websockets'])
      //         .enableForceNew()
      //         .disableAutoConnect()
      //         .build());

      //   //Configure socket Transport
      socket = io(generalUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'forceNew': true
      });
      socket.connect();
      socket.on('connect', (data) => print('Connected:' + socket.id!));
    } catch (e) {
      print(e.toString());
    }
  }

  setupSocketListener() {
    socket.on('_getAllChats', (allChats) {
      var chats = allChats['chats'];
      for (var data in chats) {
        dynamic list =
            // chatController.chatMessages.where((chat) => chat.id == data['_id']);

            Future.delayed(Duration(microseconds: 2));
        if (list.length == 0) {
          //   setState(() {
          // chatController.chatMessages.add(UsersMessage.fromJson(data));
          //   });
        }
      }
    });
  }

  void readLocal() {
    String currentUserId = widget.sendersid;
    String peerId = widget.clickeduserid;
    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }
  }

  Future<void> sendMessage(message) async {
    // FocusScope.of(context).unfocus(); //this unfocusses the keybaord
    Map<String, dynamic>? messageJson = {
      "sendersid": widget.sendersid,
      "senderEmail": widget.senderEmail,
      "receiverEmail": widget.senderEmail,
      "messageText": message,
    };

    socket.emit('sendMessage',
        {"data": messageJson, "chatID": groupChatId}); //sends data to back
    setState(() {
      messageJson = null;
    });
    _controller.clear(); //clears the text in the text field
  }
}
