// This class represents card owned by the user
class CardEntity {
  String? id;
  String _label;
  String _holderName;
  int _number;
  int _safeCode;
  DateTime _expirationDate;

  CardEntity(this._label, this._holderName, this._number, this._safeCode,
      this._expirationDate, {this.id});

  // The factory return type allows us to return an object mapped from json
  // Here we want to convert a Json object from the database to the Card object
  factory CardEntity.fromDBJson(Map<String, dynamic> json, String documentId) {
    return CardEntity(json['label'], json['holderName'], json['number'], json['safeCode'],
        json['expirationDate'].toDate(), id: documentId);
  }

  // This methods converts a Card object to a Json object
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'label': _label,
      'holderName': _holderName,
      'number': _number,
      'safeCode': _safeCode,
      'expirationDate': _expirationDate,
    };
  }

  String get label => _label;

  set label(String newlabel) {
    _label = label;
  }

  String get holderName => _holderName;

  set holderName(String newHolderName) {
    _holderName = newHolderName;
  }

  int get number => _number;

  set number(int newNumber) {
    _number = newNumber;
  }

  int get safeCode => _safeCode;

  set safeCode(int newSafeCode) {
    _safeCode = newSafeCode;
  }

  DateTime get expirationDate => _expirationDate;

  set expirationDate(DateTime newExpirationDate) {
    _expirationDate = newExpirationDate;
  }
}
