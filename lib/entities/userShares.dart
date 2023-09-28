// This class represents shares owned by the user
class UserShares {
  String? id;
  String _symbol;
  int _nbShares;

  UserShares(this._symbol, this._nbShares, {this.id});

  // The factory return type allows us to return an object mapped from json
  // Here we want to convert a Json object from the database to the UserShares object
  factory UserShares.fromDBJson(Map<String, dynamic> json, String documentId) {
    return UserShares(json['symbol'], json['nbShares'], id: documentId);
  }

  // This methods converts a UserShares object to a Json object
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'symbol': _symbol,
      'nbShares': _nbShares,
    };
  }

  String get symbol => _symbol;

  set symbol(String newSymbol) {
    _symbol = newSymbol;
  }

  int get nbShares => _nbShares;

  set nbShares(int newNbShares) {
    _nbShares = newNbShares;
  }
}
