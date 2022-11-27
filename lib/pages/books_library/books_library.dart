import 'package:brainworld/components/drawer.dart';
import 'package:brainworld/components/horizontal_listview.dart';
import 'package:brainworld/components/myappbar.dart';
import 'package:brainworld/components/nothing_yet_widget.dart';
import 'package:brainworld/components/utilities_widgets/loading.dart';
import 'package:brainworld/components/utilities_widgets/my_navigate.dart';
import 'package:brainworld/constants/constant.dart';
import 'package:brainworld/models/user.dart';
import 'package:brainworld/pages/books_library/add_to_books.dart';
import 'package:brainworld/pages/chats/models/books_model.dart';
import 'package:brainworld/services/auth_service.dart';
import 'package:brainworld/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../constants/api_utils_constants.dart';
import '../chats/models/isnewuser_data_model.dart';

class BooksLibrary extends StatefulWidget {
  const BooksLibrary({Key? key}) : super(key: key);

  @override
  State<BooksLibrary> createState() => _BooksLibraryState();
}

class _BooksLibraryState extends State<BooksLibrary> {
  bool loading = false;
  late IsNewUserModel userInfoData;
  late Future books_data;
  int categoryLength = 0;
  int bookLength = 0;
  @override
  void initState() {
    super.initState();
    refreshUsersBooks();
    _getUserRegInfo();

    // var index = widget.index;
  }

  _getUserRegInfo() async {
    var userInfo = await getUserRegInfo();
    if (this.mounted) {
      setState(() {
        userInfoData = IsNewUserModel.fromJson(userInfo);
      });
    }
  }

  Future refreshUsersBooks() async {
    setState(() => loading = true);

    //this.students = await TransactionService.
    //              transactionInstance.getUserTransactions(1);
    this.books_data = UploadService().getAllBooks();
    print('books_data');
    // var books_data2 = books_data as Map;
    books_data.then((value) => {
          print('value'),
          print(value['categories']),
          setState(() => categoryLength = value['categories'].length),
          setState(() => bookLength = value['books'].length)
        });
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print('userInfoData');
    // print(userInfoData?.bookLib);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: bookLength == 0 ? null : MyAppMenuBar(title: 'Books'),
      body: FutureBuilder(
          future: books_data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.data == null) {
              return Loading();
            } else {
              var book_items_map = snapshot.data! as Map;

              return
                  // book_items_map['books'].length == 0
                  userInfoData.bookLib == true
                      ? NothingYetWidget(
                          pageTitle: 'UPLOAD TO BOOKS LIBRARY',
                          pageHeader: "My Books Library",
                          pageContentText:
                              'Welcome to Brain world books you can buy books here with ease,\n'
                              'You can also sell your own books here\n at any price u want',
                          onClick: () async {
                            var userModel = IsNewUserModel(
                                id: user.id,
                                username: user.full_name,
                                newlyRegistered: true,
                                bookLib: false,
                                library: userInfoData.library == false
                                    ? false
                                    : true,
                                lab: userInfoData.lab == false ? false : true,
                                classRoom: true,
                                chat: userInfoData.chat == false ? false : true,
                                regAt: 'regAt');
                            ;
                            AuthService.setIsNewUser(userModel);
                            MyNavigate.navigatejustpush(AddToBooks(), context);
                          },
                        )
                      : Stack(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 5),
                                // color: Color.fromARGB(255, 13, 39, 127),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: myOrangeGradientTransparent)),
                                height: size(context).height * 0.22,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        child: Image.asset(
                                          "assets/images/brainworld-logo.png",
                                          height: 80,
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Brain World',
                                          style: TextStyle(
                                              color: myhomepageBlue,
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'Buy books at ease here on brain world',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/svg/booksicon.svg',
                                                    height: 12,
                                                    fit: BoxFit.fill,
                                                    color: Colors.white,
                                                    semanticsLabel:
                                                        'A red up arrow'),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${bookLength} books in your library',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  IconlyBold.scan,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${categoryLength} shelfs',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Align(
                                // top: 1,
                                alignment: Alignment(
                                    0, -size(context).height * 0.00081),
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: textField())),
                            book_items_map['books'].length == 0
                                ? NothingYetWidget(
                                    pageTitle: '',
                                    pageHeader: "No Books Yet",
                                    isFullPage: false,
                                    pageContentText:
                                        'Welcome to Brain world books you can buy books here with ease,\n'
                                        'You can also sell your own books here\n at any price u want',
                                    onClick: () async {
                                      MyNavigate.navigatejustpush(
                                          AddToBooks(), context);
                                    },
                                  )
                                : Padding(
                                    // alignment: Alignment(0, size(context).height * 0.00069),
                                    padding: EdgeInsets.only(
                                        top: size(context).height * 0.3),
                                    child: FutureBuilder(
                                        future: books_data,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          } else if (snapshot.data == null) {
                                            return Loading();
                                          } else {
                                            var book_items_map =
                                                snapshot.data! as Map;
                                            List<BookModel> books = [];
                                            for (var data
                                                in book_items_map['books']) {
                                              books.add(
                                                  BookModel.fromJson(data));
                                            }
                                            return SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  libraryList(list: books),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                        'Your Shelfs/Categories',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  ),
                                                  Container(
                                                    height: 250,
                                                    padding: EdgeInsets.only(
                                                        bottom: 50),
                                                    child: ListView.builder(
                                                        // scrollDirection: Axis.horizontal,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        itemCount:
                                                            book_items_map[
                                                                    'categories']
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return libraryList(
                                                              list: books,
                                                              category:
                                                                  book_items_map[
                                                                          'categories']
                                                                      [index]);
                                                        }),
                                                  )
                                                  // libraryList(context),
                                                ],
                                              ),
                                            );
                                          }
                                        })),
                          ],
                        );
            }
          }),
    );
  }

  Column libraryList({required List<BookModel> list, category}) {
    List<BookModel> newList = [];
    if (category != null) {
      for (var book in list) {
        if (book.category == category) {
          // setState(() {
          // });
          newList.add(book);
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0).copyWith(left: 16, top: 0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: myblueGradientTransparent)),
                margin: EdgeInsets.only(right: 4),
                height: 14,
                width: 6,
              ),
              Text(
                category != null ? category : 'All books',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Container(
            height: 185.0,
            // width: size(context).width * 1.1,
            child: HorizontalListView(
              pageType: 'books',
              list: category != null ? newList : list,
              size: size(context),
            )),
      ],
    );
  }

  Container textField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 50.0,
              spreadRadius: 2.0,
            ),
          ]),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'Search here...',
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: myhomepageBlue, width: 0.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: Icon(
              IconlyBold.search,
              color: iconsColor,
            )),
      ),
    );
  }
}
