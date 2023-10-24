import 'package:stock_market_app/repositories/symbolRepository.dart';

// This class allows us to call the repository and avoid direct calls to the database
class SymbolService {
  SymbolRepository symbolRepository = SymbolRepository();

  // Returns all the symbols
  Future<List<String>?> getAllSymbols() async {
    return (await symbolRepository.getAllSymbols())?.map((symbol) => symbol.symbol).toList();
  }

  // Returns all the companies
  Future<List<String>?> getAllCompanyNames() async {
    return (await symbolRepository.getAllSymbols())?.map((symbol) => symbol.companyName).toList();
  }

  // Returns the symbol of a company
  Future<String?> getSymbolByCompanyName(String companyName) async {
    return await symbolRepository.getSymbolByCompanyName(companyName);
  }

  // Returns the campany name of a symbol
  Future<String?> getCompanyNameBySymbol(String symbol) async {
    return await symbolRepository.getCompanyNameBySymbol(symbol);
  }
}
