import 'package:flutter/material.dart';
import 'Logins/Login.dart';
import 'RouteGenerator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
        primaryColor: Colors.lightBlue[100], accentColor: Colors.black),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
