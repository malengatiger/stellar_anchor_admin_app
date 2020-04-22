import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stellar_anchor_admin_app/api/net.dart';
import 'package:stellar_anchor_admin_app/api/util/util.dart';
import 'package:stellar_anchor_admin_app/ui/desktop/splash_desktop.dart';
import 'package:stellar_anchor_admin_app/ui/mobile/splash_mobile.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool _first = true;
  double left = 0.0, top = 40.0;

  initState() {
//    _controller = AnimationController(
//      vsync: this,
//      duration: const Duration(seconds: 1),
//    );
    super.initState();
    debugPrint("💙 💙 💙 ... initState .....");
    _setEnvironment();
  }

  _setEnvironment() async {
    var url = await getBaseUrl();
    debugPrint(
        '🔆 🔆 🔆  Splash: url from properties dor.env file: 🔵 🔵 $url');
    _getAnchor();
  }

  _moveUp() {
    setState(() {
      left = 10;
      top = 40;
    });
  }

  _moveDown() {
    setState(() {
      left = 100;
      top = 200;
    });
  }

  void _getAnchor() async {
    var ping = await NetUtil.get(headers: null, apiRoute: "ping");
    debugPrint('.... result: 🍎 🍎 🍎 $ping');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🍎 🍎 🍎 .... build .....");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              ScreenTypeLayout(
                mobile: SplashMobile(),
                desktop: SplashDesktop(),
              ),
              AnimatedPositioned(
                duration: Duration(seconds: 1),
                left: left,
                top: top,
                curve: _first ? Curves.easeInOut : Curves.bounceOut,
                child: GestureDetector(
                  onTap: () {
                    if (_first) {
                      _moveDown();
                    } else {
                      _moveUp();
                    }
                    _first = !_first;
                  },
                  child: Card(
                    elevation: 8,
                    color: Colors.pink[700],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "I float above the rest",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
