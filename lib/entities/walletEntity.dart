// This class represents a wallet (with real money)
class WalletEntity {
  String? id;
  double _balance;

  WalletEntity(this._balance, {this.id});

  // The factory return type allows us to return an object mapped from json
  // Here we want to convert a Json object from the database to the Wallet object
  factory WalletEntity.fromDBJson(Map<String, dynamic> json, String documentId) {
    return WalletEntity(json['balance'], id: documentId);
  }

  // This methods converts a Wallet object to a Json object
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'balance': _balance,
    };
  }

  double get balance => _balance;

  set balance(double newBalance) {
    _balance = newBalance;
  }
}