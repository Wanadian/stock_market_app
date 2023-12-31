import 'package:flutter/material.dart';

import 'package:stock_market_app/services/shareService.dart';
import 'package:stock_market_app/services/symbolService.dart';
import 'package:stock_market_app/services/userSharesService.dart';
import 'package:stock_market_app/services/walletService.dart';
import 'package:stock_market_app/services/cardService.dart';

// This class allows us to keep an instance of each services in the context
class InheritedServices extends InheritedWidget {
  final SymbolService symbolService;
  final ShareService shareService;
  final UserSharesService userSharesService;
  final WalletService walletService;
  final CardService cardService;
  final Widget child;

  InheritedServices({required this.symbolService, required this.shareService, required this.userSharesService, required this.walletService, required this.cardService, required this.child})
      : super(child: child);

  static InheritedServices of(BuildContext context) {
    final InheritedServices? result = context.dependOnInheritedWidgetOfExactType<InheritedServices>();
    assert(result != null, 'No InheritedSymbolService found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedServices oldWidget) {
    return true;
  }
}