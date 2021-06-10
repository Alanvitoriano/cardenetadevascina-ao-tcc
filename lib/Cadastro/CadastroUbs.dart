import 'package:flutter/material.dart';
import 'package:vacinaon/Cadastro/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroUbs extends StatefulWidget {
  @override
  _CadastroUbsState createState() => _CadastroUbsState();
}

class _CadastroUbsState extends State<CadastroUbs> {
  //controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerEndUbs = TextEditingController();
  String _mensagemErro = "";
  bool _senhaMostrar = false;
  //metodo para validar os campos do usuario
  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    String endereco = _controllerEndUbs.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6) {
          setState(() {
            _mensagemErro = "";
          });
          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          usuario.endereco = endereco;

          _cadastrarUsuario(usuario);
        } else {
          setState(() {
            _mensagemErro = "preencha a senha! maior que 6 digitos";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "preencha o Email utilizando o @";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "preencha o nome";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((FirebaseUser) {
      //Salvar dados do usuario
      Firestore db = Firestore.instance;
      db
          .collection("ubsLocal")
          .document(FirebaseUser.uid)
          .setData(usuario.toMap());

      Navigator.pushNamedAndRemoveUntil(context, "/homeUbs", (_) => false);
    }).catchError((error) {
      print("erro app:" + error.toString());
      setState(() {
        _mensagemErro =
            "Erro ao cadastrar usuario, verifique os campos e tente novamente";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro (UBS)"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome UBS",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerSenha,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: !this._senhaMostrar,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.security),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye,
                                color: this._senhaMostrar
                                    ? Colors.blue
                                    : Colors.grey),
                            onPressed: () {
                              setState(() =>
                                  this._senhaMostrar = !this._senhaMostrar);
                            }),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEndUbs,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Endereço",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      color: Colors.lightBlue[100],
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        _validarCampos();
                      }),
                ),
                Center(
                    child: Text(
                  _mensagemErro,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
