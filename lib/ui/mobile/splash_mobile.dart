import 'package:flutter/material.dart';
import 'package:stellar_anchor_admin_app/ui/desktop/splash_desktop.dart';
import 'package:stellar_anchor_admin_app/util/util.dart';

class SplashMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    p('🍎 🍎  🍎  🍎  🍎  SplashMobile:build running 💙');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IntroductionCard(),
        SizedBox(
          height: 24,
        )
      ],
    );
  }
}
