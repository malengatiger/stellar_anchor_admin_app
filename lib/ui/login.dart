import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stellar_anchor_admin_app/ui/mobile/mobile_login.dart';
import 'package:stellar_anchor_library/util/util.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: baseColor,
      body: ScreenTypeLayout(
        mobile: LoginMobile(),
      ),
    ));
  }
}
