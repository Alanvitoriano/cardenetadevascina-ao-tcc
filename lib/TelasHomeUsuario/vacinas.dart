import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vacinaon/TelasHomeUsuario/CadastrarVacinasSegundaDose.dart';
import 'package:vacinaon/cadastrarVacinasUsuarios.dart';

class Vacinas extends StatefulWidget {
  @override
  _VacinasState createState() => _VacinasState();
}

class _VacinasState extends State<Vacinas> {
  TextEditingController _controllerNomeVacina = TextEditingController();
  TextEditingController _controllerLote = TextEditingController();
  TextEditingController _controllerCNES = TextEditingController();
  TextEditingController _controllerFabricanteVacina = TextEditingController();
  TextEditingController _controllerDataPrimeiraDose = TextEditingController();
  TextEditingController _controllerUnidade = TextEditingController();
  TextEditingController _controllerNomeVacinador = TextEditingController();
  TextEditingController _controllerCorenVacinador = TextEditingController();
  TextEditingController _controllerNomeVacinaSegunda = TextEditingController();
  TextEditingController _controllerLoteSegunda = TextEditingController();
  TextEditingController _controllerCNESSegunda = TextEditingController();
  TextEditingController _controllerFabricanteVacinaSegunda =
      TextEditingController();
  TextEditingController _controllerDataSegundaDose = TextEditingController();
  TextEditingController _controllerUnidadeSegunda = TextEditingController();
  TextEditingController _controllerNomeVacinadorSegunda =
      TextEditingController();
  TextEditingController _controllerCorenVacinadorSegunda =
      TextEditingController();
  String _idUsuarioLogado;
  Firestore db = Firestore.instance;

  // processo para adcionar vacinas
  _adcionarVacinas() async {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.lightBlue[100],
              foregroundColor: Colors.black,
              elevation: 10,
              mini: true,
              child: Icon(Icons.save_sharp),
              onPressed: () {
                _ValidarCamposVacinas();
                Navigator.pop(context);
              },
            ),
            appBar: AppBar(
              title: Text("vacina 1ª Dose"),
            ),
            body: Container(
                child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    controller: _controllerNomeVacina,
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
                    controller: _controllerCNES,
                    decoration: InputDecoration(
                        labelText: "CNES", hintText: "digite o Cnes"),
                  ),
                  TextField(
                    controller: _controllerFabricanteVacina,
                    decoration: InputDecoration(
                        labelText: "Fabricante",
                        hintText: "digite o nome do fabricante"),
                  ),
                  TextField(
                    controller: _controllerDataPrimeiraDose,
                    decoration: InputDecoration(
                        labelText: " Data 1ª Dose",
                        hintText: "digite o a data da primeira dose"),
                  ),
                  TextField(
                    controller: _controllerUnidade,
                    decoration: InputDecoration(
                        labelText: "Unidade",
                        hintText: "digite o Endereço da Unidade"),
                  ),
                  TextField(
                    controller: _controllerNomeVacinador,
                    decoration: InputDecoration(
                        labelText: "Nome Vacinador",
                        hintText: "digite o nome do Vacinador "),
                  ),
                  TextField(
                    controller: _controllerCorenVacinador,
                    decoration: InputDecoration(
                        labelText: "Coren-SP",
                        hintText: "digite o Coren do  Vacinador "),
                  ),
                ],
              ),
            )),
          );
        });
  }

  _adcionarSegundaDose() async {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('2ªDose'),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.lightBlue[100],
              foregroundColor: Colors.black,
              elevation: 10,
              mini: true,
              child: Icon(Icons.save_sharp),
              onPressed: () {
                _ValidarCamposVacinasSegunda();
                Navigator.pushReplacementNamed(context, "/home");
              },
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      controller: _controllerNomeVacinaSegunda,
                      decoration: InputDecoration(
                          labelText: " Vacina 2ª",
                          hintText: "Digite o nome da Vacina"),
                    ),
                    TextField(
                      controller: _controllerLoteSegunda,
                      decoration: InputDecoration(
                          labelText: "Lote 2ª",
                          hintText: "Digite o numero do lote"),
                    ),
                    TextField(
                      controller: _controllerCNESSegunda,
                      decoration: InputDecoration(
                          labelText: "CNES 2ª", hintText: "digite o Cnes"),
                    ),
                    TextField(
                      controller: _controllerFabricanteVacinaSegunda,
                      decoration: InputDecoration(
                          labelText: "Fabricante 2ª",
                          hintText: "digite o nome do fabricante"),
                    ),
                    TextField(
                      controller: _controllerDataSegundaDose,
                      decoration: InputDecoration(
                          labelText: " Data 2ª Dose",
                          hintText: "digite o a data da primeira dose"),
                    ),
                    TextField(
                      controller: _controllerUnidadeSegunda,
                      decoration: InputDecoration(
                          labelText: "Unidade 2ª",
                          hintText: "digite o Endereço da Unidade"),
                    ),
                    TextField(
                      controller: _controllerNomeVacinadorSegunda,
                      decoration: InputDecoration(
                          labelText: "Nome Vacinador 2ª",
                          hintText: "digite o nome do Vacinador "),
                    ),
                    TextField(
                      controller: _controllerCorenVacinadorSegunda,
                      decoration: InputDecoration(
                          labelText: "Coren-SP 2ª",
                          hintText: "digite o Coren do  Vacinador "),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  /// porcesso para adcionar vacina e salvar no banco
  _ValidarCamposVacinas() {
    String vacina = _controllerNomeVacina.text;
    String lote = _controllerLote.text;
    String cnes = _controllerCNES.text;
    String dataPrimeira = _controllerDataPrimeiraDose.text;
    String enderecoUnidade = _controllerUnidade.text;
    String fabricantevacina = _controllerFabricanteVacina.text;
    String nomeVacinador = _controllerNomeVacinador.text;
    String corenVacinador = _controllerCorenVacinador.text;

    VacinasUser vacinas = VacinasUser();
    vacinas.nomevacina = vacina;
    vacinas.lote = lote;
    vacinas.cnes = cnes;
    vacinas.dataPrimeiraDose = dataPrimeira;
    vacinas.unidade = enderecoUnidade;
    vacinas.fabricante = fabricantevacina;
    vacinas.nomeVacinador = nomeVacinador;
    vacinas.corenVacinador = corenVacinador;
    vacinas.dataprimeira = Timestamp.now().toString();
    _controllerNomeVacina.clear();
    _controllerLote.clear();
    _controllerCNES.clear();
    _controllerFabricanteVacina.clear();
    _controllerDataPrimeiraDose.clear();
    _controllerUnidade.clear();
    _controllerNomeVacinador.clear();
    _controllerCorenVacinador.clear();

    _cadastrarVacinas(vacinas);
  }

  //Salvar dados do usuario 1
  _cadastrarVacinas(VacinasUser vacina) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .collection("vacinasUsuarios")
        .add(vacina.toMap());
  }

  //metodo para recupera vacina
  final _controllerUser = StreamController<QuerySnapshot>.broadcast();
  Future<Stream<QuerySnapshot>> _recuperarVacinas() {
    final stream = db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .collection("vacinasUsuarios")
        .orderBy("DataSalvar1ª", descending: true)
        .snapshots();

    stream.listen((dados) {
      _controllerUser.add(dados);
    });
  }

  _ValidarCamposVacinasSegunda() {
    String vacinaSeg = _controllerNomeVacinaSegunda.text;
    String loteSeg = _controllerLoteSegunda.text;
    String cnesSeg = _controllerCNESSegunda.text;
    String dataSeg = _controllerDataSegundaDose.text;
    String enderecoUnidadeSeg = _controllerUnidadeSegunda.text;
    String fabricantevacinaSeg = _controllerFabricanteVacinaSegunda.text;
    String nomeVacinadorSeg = _controllerNomeVacinadorSegunda.text;
    String corenVacinadorSeg = _controllerCorenVacinadorSegunda.text;

    VacinasUserSegunda vacinasSeg = VacinasUserSegunda();
    vacinasSeg.nomevacinaSeg = vacinaSeg;
    vacinasSeg.loteSeg = loteSeg;
    vacinasSeg.cnesSeg = cnesSeg;
    vacinasSeg.dataSeg = dataSeg;
    vacinasSeg.unidadeSeg = enderecoUnidadeSeg;
    vacinasSeg.fabricanteSeg = fabricantevacinaSeg;
    vacinasSeg.nomeVacinadorSeg = nomeVacinadorSeg;
    vacinasSeg.corenVacinadorSeg = corenVacinadorSeg;

    _cadastrarVacinasSegunda(vacinasSeg);
  }

  //Salvar dados do usuario 1
  _cadastrarVacinasSegunda(VacinasUserSegunda vacina) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .collection("vacinasUsuariosSegunda")
        .add(vacina.toMap());
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[100],
        foregroundColor: Colors.black,
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          _adcionarVacinas();
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controllerUser.stream,
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
                      DocumentSnapshot itemUser = vacinas[indice];
                      String nomevacina = itemUser["Vacinas1ª"];
                      String lote = itemUser["Lote1ª"];
                      String cnes = itemUser["CNES1ª"];
                      String data = itemUser["Data1ª"];
                      String unidade = itemUser["Unidade1ª"];
                      String fabricante = itemUser["Fabricante1ª"];
                      String nomevacinador = itemUser["NomeVacinador1ª"];
                      String corenvacinador = itemUser["Coren-SP1ª"];
                      return Card(
                        child: ListTile(
                          title: Text(
                            "Nome Vacina: " + nomevacina,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text("unidade:" + unidade),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("VACINA : " +
                                        nomevacina +
                                        "\nUNIDADE : " +
                                        unidade +
                                        "\nDATA : " +
                                        data +
                                        "\nCNES : " +
                                        cnes +
                                        "\nLOTE :" +
                                        lote +
                                        "\nFABRICANTE :" +
                                        fabricante +
                                        "\nVACINADOR :" +
                                        nomevacinador +
                                        "\nCOREN-SP :" +
                                        corenvacinador +
                                        "\n\n(Observação caso sua vacina tenha segunda dose clica em segunda dose)"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Fechar"),
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            _adcionarSegundaDose();
                                          },
                                          child: Text("2ª dose"))
                                    ],
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
