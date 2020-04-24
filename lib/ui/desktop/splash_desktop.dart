import 'package:flutter/material.dart';
import 'package:stellar_anchor_admin_app/util/util.dart';

class SplashDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    p('SplashDesktop running 💙');
    return Row(
      children: <Widget>[
        IntroductionCard(),
      ],
    );
  }
}

class IntroductionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              lorem,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class CallToAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 4,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Create Anchor Agent",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        onPressed: () {
          print("🍎 🍎 Call to Action Tapped!  🍎");
        });
  }
}
