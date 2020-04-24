import 'dart:math';

import 'package:stellar_anchor_admin_app/util/util.dart';

class RandomImage {
  static List<String> images = List();
  static Random _random = Random(DateTime.now().millisecondsSinceEpoch);
  RandomImage() {
    p('RandomImage constructor 🔆 🔆 🔆 🔆 ');
    _loadImages();
  }
  static _loadImages() {
    for (var index = 0; index < 31; index++) {
      images.add('assets/images/m${index + 1}.jpeg');
    }
  }

  static String getImage() {
    if (images.isEmpty) {
      _loadImages();
    }
    int index = _random.nextInt(images.length - 1);
    return images.elementAt(index);
  }
}
