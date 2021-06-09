import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vacinaon/Cadastro/Usuario.dart';
import 'package:vacinaon/TelasHomeUsuario/Homecontato.dart';
import 'package:vacinaon/TelasHomeUsuario/segundaDose.dart';
import 'package:vacinaon/TelasHomeUsuario/vacinas.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String _emailUsuario = "";
  String _idUsuarioLogado;

  TabController _tabController;

  List<String> itensMenu = [
    "Configuração",
    "Deslogar",
  ];

  // String _emailUsuario = "";
  Future _recuperarDadosUsuarios() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuarios();

    _tabController = TabController(length: 2, vsync: this);
  }

  _escolhaMenuItem(String itemEscolhido) {
    // print("item Escolhido:" + itemEscolhido);

    switch (itemEscolhido) {
      case "Configuração":
        //  Navigator.pushNamed(context, "/configuracoes");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  ///metodo para Deslogar o usuario do sistema....
  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Vacinas"),
        bottom: TabBar(
          indicatorWeight: 3,
          indicatorColor: Colors.black,
          controller: _tabController,
          labelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          tabs: <Widget>[
            Tab(text: "Vacinas \n1ª Dose"),
            Tab(text: "Vacinas \n2ª Dose")
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu_open),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Homecontato()));
              }),
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[Vacinas(), SegundaDose()],
      ),
    );
  }
}
