import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:stock_market_app/context/rootWidget.dart';
import 'package:stock_market_app/screens/splashScreen.dart';
import 'package:stock_market_app/firebase_options.dart';

Future<void> main() async {
  // Connection to the database
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(RootWidget());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return KeyboardDismisser(
        gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
        child: MaterialApp(
          title: 'Stocket',
          theme: ThemeData(scaffoldBackgroundColor: Colors.grey.shade800),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ));
  }
}
