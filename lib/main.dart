import 'package:brainworld/components/bottomnavigation.dart';
import 'package:brainworld/models/user.dart';
import 'package:brainworld/services/auth_service.dart';
import 'package:brainworld/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureProvider<User?>.value(
      initialData: null,
      catchError: (_, __) => null,
      value: AuthService().getuserFromStorage(),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
