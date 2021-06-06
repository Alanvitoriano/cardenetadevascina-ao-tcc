class VacinasUser {
  String _nomevacina;
  String _lote;
  String _cnes;
  String _fabricanteVacina;
  String _dataPrimeiraDose;
  String _unidade;
  String _nomeVacinador;
  String _corenVacinador;
  String _dataSalvarprimeira;

  VacinasUser();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "Vacinas1ª": this.nomevacina,
      "Lote1ª": this._lote,
      "CNES1ª": this._cnes,
      "Data1ª": this._dataPrimeiraDose,
      "Unidade1ª": this._unidade,
      "Fabricante1ª": this._fabricanteVacina,
      "NomeVacinador1ª": this._nomeVacinador,
      "Coren-SP1ª": this._corenVacinador,
      "DataSalvar1ª": this._dataSalvarprimeira,
    };
    return map;
  }

  String get nomevacina => _nomevacina;
  set nomevacina(String value) {
    _nomevacina = value;
  }

  String get lote => _lote;
  set lote(String value) {
    _lote = value;
  }

  String get cnes => _cnes;
  set cnes(String value) {
    _cnes = value;
  }

  String get dataPrimeiraDose => _dataPrimeiraDose;
  set dataPrimeiraDose(String value) {
    _dataPrimeiraDose = value;
  }

  String get unidade => _unidade;
  set unidade(String value) {
    _unidade = value;
  }

  String get fabricante => _fabricanteVacina;
  set fabricante(String value) {
    _fabricanteVacina = value;
  }

  String get nomeVacinador => _nomeVacinador;
  set nomeVacinador(String value) {
    _nomeVacinador = value;
  }

  String get corenVacinador => _corenVacinador;
  set corenVacinador(String value) {
    _corenVacinador = value;
  }

  String get dataprimeira => _dataSalvarprimeira;
  set dataprimeira(String value) {
    _dataSalvarprimeira = value;
  }
}
