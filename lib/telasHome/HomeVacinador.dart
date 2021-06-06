import 'dart:async';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vacinaon/CadastrarVacinas.dart';
import 'package:vacinaon/Cadastro/Usuario.dart';

class HomeVacinador extends StatefulWidget {
  @override
  _HomeVacinadorState createState() => _HomeVacinadorState();
}

class _HomeVacinadorState extends State<HomeVacinador> {
  //TextEditingController _controllerVacina = TextEditingController();
  // TextEditingController _controllerLote = TextEditingController();
  // TextEditingController _controllerData = TextEditingController();
  // TextEditingController _controllerDataRetorno = TextEditingController();
  // TextEditingController _controlleridVacina = TextEditingController();
  String _idUsuarioLogadoVacinador;
  Firestore db = Firestore.instance;

  // processo para adcionar vacinas
  /*_adcionarVacinas() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("vacina"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: _controlleridVacina,
                  decoration:
                      InputDecoration(labelText: "ID", hintText: "Digite o ID"),
                ),
                TextField(
                  controller: _controllerVacina,
                  decoration: InputDecoration(
                      labelText: " Vacina",
                      hintText: "Digite o nome da Vacina"),
                ),
                TextField(
                  controller: _controllerLote,
                  decoration: InputDecoration(
                      labelText: "Lote", hintText: "Digite o numero do lote"),
                ),
                TextField(
                  controller: _controllerData,
                  decoration: InputDecoration(
                      labelText: "Data aplicada",
                      hintText: "digite a data da aplicação"),
                ),
                TextField(
                  controller: _controllerDataRetorno,
                  decoration: InputDecoration(
                      labelText: "Data Retorno (OPCIONAL)",
                      hintText: "digite a data de retono da aplicação"),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancelar"),
              ),
              FlatButton(
                  onPressed: () {
                    //  _ValidarCamposVacinas();
                    Navigator.pop(context);
                  },
                  child: Text("salvar"))
            ],
          );
        });
  }*/

  List<String> itensMenu = ["Configuração", "Deslogar", "Sobre"];

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
    Navigator.pushReplacementNamed(context, "/loginVacinador");
  }

  /// porcesso para adcionar vacina e salvar no banco
  /* _ValidarCamposVacinas() {
    String vacina = _controllerVacina.text;
    String lote = _controllerLote.text;
    String data = _controllerData.text;
    String dataretono = _controllerDataRetorno.text;
    String idVacina = _controlleridVacina.text;
    if (vacina.isNotEmpty) {
      if (lote.isNotEmpty) {
        if (data.isNotEmpty) {
          if (idVacina.isNotEmpty) {
            Vacinas vacinas = Vacinas();
            vacinas.nomevacina = vacina;
            vacinas.lote = lote;
            vacinas.data = data;
            vacinas.dataretono = dataretono;
            vacinas.idVacina = idVacina;
            _controlleridVacina.clear();
            _controllerVacina.clear();
            _controllerLote.clear();
            _controllerData.clear();
            _controllerDataRetorno.clear();

            _cadastrarVacinas(vacinas);
          }
        }
      }
    }
  }*/

  //Salvar dados do usuario
  /*  _cadastrarVacinas(Vacinas vacina) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogadoVacinador = usuarioLogado.uid;

    db
        .collection("vacinador")
        .document(_idUsuarioLogado)
        .collection("vacinas")
        .add(vacina.toMap());
  }
*/
  //metodo para recupera vacina
  /*final _controller = StreamController<QuerySnapshot>.broadcast();
  Future<Stream<QuerySnapshot>> _recuperarVacinas() {
    final stream = db
        .collection("vacinador")
        .document(_idUsuarioLogado)
        .collection("vacinas")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }*/

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogadoVacinador = usuarioLogado.uid;
    //  _recuperarVacinas();
  }

  @override
  initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("    vacina-ON \n  Usuario Profisional"),
        actions: <Widget>[
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[100],
        foregroundColor: Colors.black,
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          //   _adcionarVacinas();
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        //    stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: <Widget>[
                    Text("Carregando  Vacinas"),
                    CircularProgressIndicator()
                  ],
                ),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              QuerySnapshot querySnapshot = snapshot.data;
              if (snapshot.hasError) {
                return Text("Erro ao carregar os dados!");
              } else {
                return ListView.builder(
                    itemCount: querySnapshot.documents.length,
                    itemBuilder: (context, indice) {
                      //recupera mensagem
                      List<DocumentSnapshot> vacinas =
                          querySnapshot.documents.toList();
                      DocumentSnapshot item = vacinas[indice];
                      String nomevacina = item["vacinas"];
                      String lote = item["lote"];
                      String data = item["data"];
                      String dataretono = item["dataretono"];
                      String idVacina = item["idVacina"];
                      return Card(
                        child: ListTile(
                            title: Text(
                              "Nome Vacina: " + nomevacina,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text("id:" + idVacina)),
                      );
                    });
              }

              break;
          }
        },
      ),
    );
  }
}
