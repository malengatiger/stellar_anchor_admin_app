import 'package:flutter/material.dart';
import 'package:stellar_anchor_admin_app/ui/desktop/splash_desktop.dart';

class SplashMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('🍎 SplashMobile running 💙');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IntroductionCard(),
        Spacer(),
        CallToAction(),
        SizedBox(
          height: 24,
        )
      ],
    );
  }
}
