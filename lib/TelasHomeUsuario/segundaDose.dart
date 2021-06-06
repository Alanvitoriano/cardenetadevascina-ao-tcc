import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vacinaon/TelasHomeUsuario/CadastrarVacinasSegundaDose.dart';

class SegundaDose extends StatefulWidget {
  @override
  _SegundaDoseState createState() => _SegundaDoseState();
}

class _SegundaDoseState extends State<SegundaDose> {
  String _idUsuarioLogado;
  Firestore db = Firestore.instance;

  //metodo para recupera vacina
  final _controllerSeg = StreamController<QuerySnapshot>.broadcast();
  Future<Stream<QuerySnapshot>> _recuperarVacinas() {
    final stream = db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .collection("vacinasUsuariosSegunda")
        .orderBy("DataSalvar2ª", descending: true)
        .snapshots();

    stream.listen((dados) {
      _controllerSeg.add(dados);
    });
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _recuperarVacinas();
  }

  @override
  initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _controllerSeg.stream,
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
                      DocumentSnapshot itemSeg = vacinas[indice];
                      String nomevacinaSeg = itemSeg["Vacinas2ª"];
                      String loteSeg = itemSeg["Lote2ª"];
                      String cnesSeg = itemSeg["CNES2ª"];
                      String dataSeg = itemSeg["Data2ª"];
                      String unidadeSeg = itemSeg["Unidade2ª"];
                      String fabricanteSeg = itemSeg["Fabricante2ª"];
                      String nomevacinadorSeg = itemSeg["NomeVacinador2ª"];
                      String corenvacinadorSeg = itemSeg["Coren-SP2ª"];
                      return Card(
                        child: ListTile(
                          title: Text(
                            "Nome Vacina: " + nomevacinaSeg,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text("unidade:"),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text("VACINA : " +
                                        nomevacinaSeg +
                                        "\nUNIDADE : " +
                                        unidadeSeg +
                                        "\nDATA : " +
                                        dataSeg +
                                        "\nCNES : " +
                                        cnesSeg +
                                        "\nLOTE :" +
                                        loteSeg +
                                        "\nFABRICANTE :" +
                                        fabricanteSeg +
                                        "\nVACINADOR :" +
                                        nomevacinadorSeg +
                                        "\nCOREN-SP :" +
                                        corenvacinadorSeg),
                                  );
                                });
                          },
                        ),
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
