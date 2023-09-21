import 'package:flutter/material.dart';

import 'balance.dart';

class ModifyBalance extends StatefulWidget {
  const ModifyBalance({Key? key}) : super(key: key);

  @override
  State<ModifyBalance> createState() => _ModifyBalanceState();
}

class _ModifyBalanceState extends State<ModifyBalance> {

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // TODO : rename button when image is found
        label: Text('Return to my safe'),
        icon: Icon(Icons.attach_money),
        onPressed: () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>Balance()));
          });
        },
      ),
    );;
  }
}