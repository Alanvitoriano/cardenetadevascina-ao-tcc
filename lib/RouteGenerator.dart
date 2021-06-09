import 'package:flutter/material.dart';
import 'package:vacinaon/Cadastro/CadastroUsuario.dart';
import 'package:vacinaon/Cadastro/CadastroVacinador.dart';
import 'package:vacinaon/Cadastro/CadastroUbs.dart';
import 'package:vacinaon/Escolhar.dart';
import 'package:vacinaon/Logins/escolharlogins.dart';
import 'package:vacinaon/Logins/telainicial.dart';
import 'package:vacinaon/TelasHomeUsuario/Homecontato.dart';
import 'package:vacinaon/telasHome/Home.dart';
import 'package:vacinaon/telasHome/HomeUbs.dart';
import 'package:vacinaon/telasHome/HomeVacinador.dart';
import 'Logins/Login.dart';
import 'Logins/LoginUbs.dart';
import 'Logins/LoginVacinador.dart';

class RouteGenerator {
  //static const String ROTA_HOME = "/home";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => telainicial());
      case "/telainicial":
        return MaterialPageRoute(builder: (_) => telainicial());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/loginVacinador":
        return MaterialPageRoute(builder: (_) => LoginVacinador());
      case "/loginUbs":
        return MaterialPageRoute(builder: (_) => LoginUbs());
      case "/escolhar":
        return MaterialPageRoute(builder: (_) => Escolhar());
      case "/escolharlogins":
        return MaterialPageRoute(builder: (_) => escolharlogins());
      case "/cadastroUbs":
        return MaterialPageRoute(builder: (_) => CadastroUbs());
      case "/cadastroVacinador":
        return MaterialPageRoute(builder: (_) => CadastroVacinador());
      case "/cadastroUsuario":
        return MaterialPageRoute(builder: (_) => CadastroUsuario());
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
      case "/homecontato":
        return MaterialPageRoute(builder: (_) => Homecontato());
      case "/homeVacinador":
        return MaterialPageRoute(builder: (_) => HomeVacinador());
      case "/homeUbs":
        return MaterialPageRoute(builder: (_) => HomeUbs());
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela nao encontrada!"),
        ),
        body: Center(
          child: Text("Tela nao encontrada!"),
        ),
      );
    });
  }
}
