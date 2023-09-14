import 'package:flutter/material.dart';
import 'package:stock_market_app/screens/wallet.dart';

class InheritedWallet extends InheritedWidget {
  final Wallet wallet;
  final Widget child;
  // TODO : Exemple de méthode appelant Wallet
  final VoidCallback saveWalletAmount;

  InheritedWallet({required this.wallet, required this.child, required this.saveWalletAmount})
      : super(child: child);

  static InheritedWallet of(BuildContext context) {
    final InheritedWallet? result = context.dependOnInheritedWidgetOfExactType<InheritedWallet>();
    assert(result != null, 'No InheritedCartItems found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedWallet oldWidget) {
    return true;
  }
}