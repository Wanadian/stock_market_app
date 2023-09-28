import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_market_app/errors/symbolError.dart';
import 'package:stock_market_app/classes/symbol.dart';

// This class is used to call the database
class SymbolRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('symbols');

  // Returns all the symbols from the database
  Future<List<String>> getSymbols() async {
    List<String> allSymbols = [];

    try {
      await collection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allSymbols.add(result.get('symbol'));
        }
      });
    } catch (error) {
      throw SymbolError(error.toString());
    }

    return allSymbols;
  }

  // Returns all the companies from the database
  Future<List<String>> getCompanyNames() async {
    List<String> allCompanyNames = [];

    try {
      await collection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allCompanyNames.add(result.get('companyName'));
        }
      });
    } catch (error) {
      throw SymbolError(error.toString());
    }

    return allCompanyNames;
  }

  // Returns the symbol of a company from database
  Future<String?> getSymbolByCompanyName(String companyName) async {
    String? symbol;

    try {
      await collection
          .where('companyName', isEqualTo: companyName)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          symbol = result.get('symbol');
        }
      });
    } catch (error) {
      throw SymbolError(error.toString());
    }

    return symbol;
  }

  // Returns the campany name of a symbol from database
  Future<String?> getCompanyNameBySymbol(String symbol) async {
    String? companyName;

    try {
      await collection
          .where('symbol', isEqualTo: symbol)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          companyName = result.get('companyName');
        }
      });
    } catch (error) {
      throw SymbolError(error.toString());
    }

    return companyName;
  }

  // Adds a symbol in the database
  Future<DocumentReference> addSymbol(Symbol symbol) {
    return collection.add(symbol.toJson());
  }
}
