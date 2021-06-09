import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vacinaon/TelasHomeUsuario/ContatoUbs.dart';
import 'package:vacinaon/TelasHomeUsuario/ContatoVacinador.dart';

class Homecontato extends StatefulWidget {
  @override
  _HomecontatoState createState() => _HomecontatoState();
}

class _HomecontatoState extends State<Homecontato>
    with SingleTickerProviderStateMixin {
  String _emailUsuario = "";
  String _idUsuarioLogado;

  TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        bottom: TabBar(
          indicatorWeight: 2,
          indicatorColor: Colors.black,
          controller: _tabController,
          labelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          tabs: <Widget>[
            Tab(
              text: "Vacinadores",
            ),
            Tab(
              text: "Ubs Locais",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[ContatoVacinador(), ContatoUbs()],
      ),
    );
  }
}
