import 'package:flutter/material.dart';
import 'package:vacinaon/Logins/telainicial.dart';
import 'Logins/Login.dart';
import 'Logins/escolharlogins.dart';
import 'RouteGenerator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: telainicial(),
    theme: ThemeData(
        primaryColor: Colors.lightBlue[100], accentColor: Colors.black),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
