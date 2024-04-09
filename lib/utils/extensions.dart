/*extension StringWrapperExtension on StringWrapper {
  String reverse() {
    return value.split('').reversed.join();
  }
}*/

import 'package:change_language/app_localizations.dart';
import 'package:flutter/material.dart';


//TODO se creo una extension para no estar realizando el of del AppLocalizations
extension ContextLocaleExtension on BuildContext {
  String getString(String key) {
    String? translate = AppLocalizations.of(this)?.translate(key);

    if (translate == null) {
      throw Exception(
          "Key not found, remember add key in json translate files");
    }
    return translate;
  }
}
