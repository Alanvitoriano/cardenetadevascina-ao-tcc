class Vacinas {
  String _nomevacina;
  String _lote;
  String _data;
  String _dataretono;
  String _idVacina;

  Vacinas();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "vacinas": this.nomevacina,
      "lote": this.lote,
      "data": this.data,
      "dataretono": this.dataretono,
      "idVacina": this.idVacina,
    };
    return map;
  }

  String get idVacina => _idVacina;
  set idVacina(String value) {
    _idVacina = value;
  }

  String get nomevacina => _nomevacina;
  set nomevacina(String value) {
    _nomevacina = value;
  }

  String get lote => _lote;
  set lote(String value) {
    _lote = value;
  }

  String get data => _data;
  set data(String value) {
    _data = value;
  }

  String get dataretono => _dataretono;
  set dataretono(String value) {
    _dataretono = value;
  }
}
