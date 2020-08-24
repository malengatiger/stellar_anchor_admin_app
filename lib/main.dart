import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stellar_anchor_admin_app/ui/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnchorAdmin',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          textTheme: GoogleFonts.ralewayTextTheme()),
//      home: PayfastTester(),
      home: Splash(),
    );
  }
}
