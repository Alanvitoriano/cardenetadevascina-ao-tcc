class VacinasUserSegunda {
  String _nomevacinaSegunda;
  String _loteSegunda;
  String _cnesSegunda;
  String _fabricanteVacinaSegunda;
  String _dataSegundaDose;
  String _unidadeSegunda;
  String _nomeVacinadorSegunda;
  String _corenVacinadorSegunda;
  String _dataSalvarSegunda;

  VacinasUserSegunda();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "Vacinas2ª": this._nomevacinaSegunda,
      "Data2ª": this._dataSegundaDose,
      "Lote2ª": this._loteSegunda,
      "CNES2ª": this._cnesSegunda,
      "Unidade2ª": this._unidadeSegunda,
      "Fabricante2ª": this._fabricanteVacinaSegunda,
      "NomeVacinador2ª": this._nomeVacinadorSegunda,
      "Coren-SP2ª": this._corenVacinadorSegunda,
      "DataSalvar2ª": this._dataSalvarSegunda,
    };
    return map;
  }

  String get nomevacinaSeg => _nomevacinaSegunda;
  set nomevacinaSeg(String value) {
    _nomevacinaSegunda = value;
  }

  String get loteSeg => _loteSegunda;
  set loteSeg(String value) {
    _loteSegunda = value;
  }

  String get cnesSeg => _cnesSegunda;
  set cnesSeg(String value) {
    _cnesSegunda = value;
  }

  String get unidadeSeg => _unidadeSegunda;
  set unidadeSeg(String value) {
    _unidadeSegunda = value;
  }

  String get fabricanteSeg => _fabricanteVacinaSegunda;
  set fabricanteSeg(String value) {
    _fabricanteVacinaSegunda = value;
  }

  String get nomeVacinadorSeg => _nomeVacinadorSegunda;
  set nomeVacinadorSeg(String value) {
    _nomeVacinadorSegunda = value;
  }

  String get corenVacinadorSeg => _corenVacinadorSegunda;
  set corenVacinadorSeg(String value) {
    _corenVacinadorSegunda = value;
  }

  String get dataSeg => _dataSegundaDose;
  set dataSeg(String value) {
    _dataSegundaDose = value;
  }

  String get dataSegunda => _dataSalvarSegunda;
  set dataSegunda(String value) {
    _dataSalvarSegunda = value;
  }
}
