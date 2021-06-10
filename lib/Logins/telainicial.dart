import 'package:flutter/material.dart';
import 'package:vacinaon/Logins/escolharlogins.dart';

class telainicial extends StatefulWidget {
  @override
  _telainicialState createState() => _telainicialState();
}

class _telainicialState extends State<telainicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Image.asset(
            "imagens/Carteira (2).png",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[100],
        foregroundColor: Colors.black,
        elevation: 30,
        child: Icon(Icons.home),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => escolharlogins()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
