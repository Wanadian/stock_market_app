// This class represents the symbol of a company
class SymbolEntity {
  String _symbol;
  String _companyName;

  SymbolEntity(this._symbol, this._companyName);

  // The factory return type allows us to return an object mapped from json
  // Here we want to convert a Symbol object from the database
  factory SymbolEntity.fromDBJson(Map<String, dynamic> json) {
    return SymbolEntity(json['symbol'], json['companyName']);
  }

  // This methods converts a Symbol object to a Json object
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'symbol': _symbol,
      'companyName': _companyName,
    };
  }

  String get symbol => _symbol;

  set symbol(String newSymbol) {
    _symbol = newSymbol;
  }

  String get companyName => _companyName;

  set companyName(String newCompanyName) {
    _companyName = newCompanyName;
  }
}
