import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class DisplayBalanceWidget extends StatefulWidget {
  double _balance;

  DisplayBalanceWidget({Key? key, required double balance})
      : _balance = balance,
        super(key: key);

  @override
  State<DisplayBalanceWidget> createState() => _DisplayBalanceWidgetState();
}

class _DisplayBalanceWidgetState extends State<DisplayBalanceWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late AnimationController _standByAnimationController;
  late Animation _standByAnimation;
  bool _isSafeOpen = false;

  void _setIsSafeOpenToOpposite(bool isSafeOpen) {
    setState(() {
      _isSafeOpen = !isSafeOpen;
    });
  }

  String _getMoneyImage(double amount) {
    if (amount <= 1000) {
      return 'assets/coins.png';
    }
    if (amount > 1000 && amount <= 10000) {
      return 'assets/money.png';
    }
    return 'assets/money-bag.png';
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _standByAnimationController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _standByAnimationController = AnimationController(
        duration: (const Duration(milliseconds: 600)), vsync: this);
    _standByAnimation =
        Tween<double>(begin: 0, end: 25).animate(_standByAnimationController)
          ..addStatusListener((status) {
            if (!_isSafeOpen) {
              if (status == AnimationStatus.completed) {
                _standByAnimationController.reverse();
              }
              if (status == AnimationStatus.dismissed) {
                _standByAnimationController.forward();
              }
            } else if (_isSafeOpen) {
              _standByAnimationController.reverse();
            }
          });
    _standByAnimationController.forward();

    _animationController = AnimationController(
        duration: (const Duration(milliseconds: 500)), vsync: this);
    _animation =
        Tween<double>(begin: 0, end: 70).animate(_animationController);
    ;
  }

  @override
  Widget build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: Listenable.merge(
            [_standByAnimationController, _animationController]),
        builder: (context, _) {
          return Container(
            child: Column(
              children: [
                if (_isSafeOpen) ...[
                  AnimatedDigitWidget(
                    duration: Duration(seconds: 1),
                    value: widget._balance,
                    enableSeparator: true,
                    fractionDigits: 2,
                    suffix: ' \$',
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  )
                ] else ...[
                  Text('Click to display your balance',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
                Container(
                  height: _animation.value,
                ),
                Container(
                  height: _standByAnimation.value,
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: _isSafeOpen
                      ? Image.asset(_getMoneyImage(widget._balance),
                          width: screenWidth * 0.5)
                      : Image.asset('assets/wallet.png',
                          width: screenWidth * 0.5),
                  iconSize: 300,
                  onPressed: () {
                    if (!_isSafeOpen) {
                      _setIsSafeOpenToOpposite(_isSafeOpen);
                      _animationController.forward();
                    } else if (_isSafeOpen) {
                      _setIsSafeOpenToOpposite(_isSafeOpen);
                      _animationController.reverse();
                      _standByAnimationController.forward();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
}
