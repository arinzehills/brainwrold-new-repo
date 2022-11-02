import 'dart:async';
import 'dart:io';
import 'package:brainworld/components/bottomnavigation.dart';
import 'package:brainworld/components/utilities_widgets/loading.dart';
import 'package:brainworld/models/user.dart';
import 'package:brainworld/pages/auth_screens/login.dart';
import 'package:brainworld/pages/getstarted_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Login();
    } else {
      return BottomNavigation();
    }
  }
}
