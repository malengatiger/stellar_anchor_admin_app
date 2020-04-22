import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> getBaseUrl() async {
  await DotEnv().load('.env');
  String devURL = DotEnv().env['devURL'];
  String prodURL = DotEnv().env['prodURL'];
  String status = DotEnv().env['status'];

  debugPrint(
      '🔵 🔵 Properties Data from dot.env file; 🔆 devURL: $devURL 🔵 🔆 prodURL: $prodURL 🔵 🔵 ');
  if (status == 'dev') {
    return devURL;
  } else {
    return prodURL;
  }
}
