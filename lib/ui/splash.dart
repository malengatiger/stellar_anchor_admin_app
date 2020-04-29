import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stellar_anchor_admin_app/ui/desktop/splash_desktop.dart';
import 'package:stellar_anchor_admin_app/ui/mobile/splash_mobile.dart';
import 'package:stellar_anchor_library/models/anchor.dart';
import 'package:stellar_anchor_library/util/prefs.dart';
import 'package:stellar_anchor_library/util/slide_right.dart';
import 'package:stellar_anchor_library/util/util.dart';
import 'package:stellar_anchor_library/widgets/round_logo.dart';
import 'agent_list.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  bool _first = true;
  double left = 0.0, top = 40.0, height = 0.0, width = 0.0;
  bool isBusy = false, navigateToAgentList = false;
  AnimationController animController, animController2;
  Animation animation, animation2;

  initState() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(animController);
    animation2 = Tween(begin: 0.0, end: 1.0).animate(animController);
    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        p(".......... 💦 💦 💦 Forward Animation completed");
      }
    });
    animController2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        p(".......... 💦 💦 💦 Reverse Animation completed, 🍎 🍎 navigate: $navigateToAgentList .........");
      }
    });
    super.initState();
    p("💙 💙 💙 ... initState .....");
    _setEnvironment();
  }

  _setEnvironment() async {
    var url = await getBaseUrl();
    p('🔆 🔆 🔆  Splash: url from properties dor.env file: 🔵 🔵 $url');
    _getAnchorUser();
  }

  AnchorUser anchorUser;
  void _getAnchorUser() async {
    setState(() {
      isBusy = true;
    });
    var name = await getAnchorId();
    p("💙 💙 💙 💙 💙 💙 This app works with STELLAR ANCHOR: 🏈 $name 🏈 (from .env file)");
    anchorUser = await Prefs.getAnchorUser();
    if (anchorUser == null) {
      Navigator.push(context, SlideRightRoute(widget: Login()));
    } else {
      p('💦 💦 💦 We good. Had a saved anchor: 💦 💦 💦 ${anchorUser.toJson()} 💦 💦 💦 ');
      p('💦 💦 💦 ....  ANCHOR from local cache: $name: 🍎 🍎 🍎 anchorUser:  ${anchorUser.toJson()}');
    }

    isBusy = false;
    setState(() {});
    animController.forward();
    //_moveDown();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 280,
                left: 32,
                child: ScaleTransition(
                  scale: animation2,
                  child: Hero(
                    tag: 'logo',
                    child: RoundLogo(radius:72, margin: 8),
                  ),
                ),
              ),
              anchorUser == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: ScaleTransition(
                        scale: animation,
                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 320,
                            ),
                            Text(anchorUser.firstName,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w900)),
                            Text(anchorUser.email,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                    ),
              Column(
                children: <Widget>[
                  ScreenTypeLayout(
                    mobile: SplashMobile(),
                    desktop: SplashDesktop(),
                  ),
                  Spacer(),
                  RaisedButton(
                      elevation: 2,
                      color: Colors.brown[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Continue ...",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      onPressed: () {
                        print("🍎 🍎 Navigating to Agent List ... !  🍎");
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.scale,
                                alignment: Alignment.topLeft,
                                duration: Duration(seconds: 2),
                                child: AgentList()));
//                        Navigator.push(
//                            context,
//                            PageTransition(
//                                type: PageTransitionType.scale,
//                                child: AgentList()));
//                        Navigator.push(
//                            context, ScaleRoute(widget: AgentList()));
                      }),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
              isBusy
                  ? Positioned(
                      left: 160,
                      bottom: 10,
                      child: Container(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
