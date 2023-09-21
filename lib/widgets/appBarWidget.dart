import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  double _balance;
  @override
  final Size preferredSize;

  AppBarWidget({Key? key, required double balance})
      : preferredSize = Size.fromHeight(100),
        _balance = balance,
        super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
      title: Text(widget._balance.toString() + ' \$'),
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
    );
  }
}
