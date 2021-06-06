class Usuario {
  String _nome;
  String _email;
  String _senha;
  String _endereco;
  String _crm;
  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "senha": this.senha,
      "crm": this.crm,
      "endereco": this.endereco,
    };
    return map;
  }

  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get nome => _nome;
  set nome(String value) {
    _nome = value;
  }

  String get endereco => _endereco;
  set endereco(String value) {
    _endereco = value;
  }

  String get crm => _crm;
  set crm(String value) {
    _crm = value;
  }
}
