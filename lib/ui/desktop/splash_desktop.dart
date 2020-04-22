import 'package:flutter/material.dart';

class SplashDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('SplashDesktop running 💙');
    return Row(
      children: <Widget>[
        IntroductionCard(),
        CallToAction(),
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
              "Agent information here",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
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
