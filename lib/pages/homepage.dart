import 'dart:math';

import 'package:brainworld/components/course_tile.dart';
import 'package:brainworld/components/drawer.dart';
import 'package:brainworld/components/myappbar.dart';
import 'package:brainworld/components/utilities_widgets/loading.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/controllers/post_controller.dart';
import 'package:brainworld/models/user.dart';
import 'package:brainworld/pages/chats/models/posts_model.dart';
import 'package:brainworld/pages/upload/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../utils/jitsi_meet_methods.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final JitsiMeetMethods _jitsiMeet = JitsiMeetMethods();
  PostsController chatUsersListController = PostsController();
  bool loading = false;
  late Socket socket;
  String commenttoShow = '';
  List<PostsModel> _post_data = [];
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    // var userId = Provider.of<User>(context, listen: false).id;
    super.initState();
    socketServer();
    getPostList();
  }

  void getPostList() {
    socket.emit('postReaction', {
      "postReaction": {"reactionType": 'none', "pageType": 'home'}
    });
    socket.on('getAllPost', (allPosts) {
      chatUsersListController.allPost.clear();
      print(allPosts['message']);
      for (var post in allPosts['posts']) {
        setStateIfMounted(() {
          chatUsersListController.allPost.add(PostsModel.fromJson(post));
        });
      }
    });
  }

  void socketServer() {
    try {
      //Configure socket Transport
      socket = io(generalUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      socket.on('connect', (data) => print('Connected:' + socket.id!));
      socket.on('connect_error',
          (error) => print('Connnection Error:' + error.message.toString()));
      socket.on('error', (error) => print('Error:' + error.message.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    // socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('users');
    // print(chatUsersListController.allPost.length);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppMenuBar(
        title: widget.title,
      ),

      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          getPostList();
          Fluttertoast.showToast(
              gravity: ToastGravity.TOP,
              msg: "Post updated",
              backgroundColor: myhomepageBlue,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            color: const Color(0xffF7F7F7),
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Obx(
                  () => chatUsersListController.allPost.length != 0
                      ? ListView.builder(
                          itemCount: chatUsersListController.allPost.length,
                          shrinkWrap: true,
                          reverse: true,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(Obx(() => PostDetail(
                                      socket: socket,
                                      post: chatUsersListController
                                          .allPost[index],
                                    )));
                              },
                              child: Obx(
                                () => CoursesTile(
                                  // post: snapshot.data[index],
                                  socket: socket,
                                  post: chatUsersListController.allPost[index],
                                  courseIndex: index,
                                  postsController: chatUsersListController,
                                ),
                              ),
                            );
                          },
                        )
                      : Loading(),
                ),
                // TextButton(
                //     onPressed: () {
                //       var random = Random();
                //       // String randoom = (random.nextInt(1000) + 1000).toString();
                //       String randoom = '8754873';
                //       _jitsiMeet.createMeeting(
                //           roomName: 'BrainWorld$randoom',
                //           isAudioMuted: true,
                //           isVideoMuted: true);
                //     },
                //     child: const Text('Join Class'))
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
