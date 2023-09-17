import 'package:flutter/material.dart';
import 'package:stock_market_app/services/symbolService.dart';

// This class allows us to keep an instance of the associated service in the context
class InheritedSymbolService extends InheritedWidget {
  final SymbolService symbolService;
  final Widget child;

  InheritedSymbolService({required this.symbolService, required this.child})
      : super(child: child);

  static InheritedSymbolService of(BuildContext context) {
    final InheritedSymbolService? result = context.dependOnInheritedWidgetOfExactType<InheritedSymbolService>();
    assert(result != null, 'No InheritedSymbolService found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedSymbolService oldWidget) {
    return true;
  }
}