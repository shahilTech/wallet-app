import 'package:flutter/foundation.dart';

void customPrint(data) {
  if (kDebugMode) {
    debugPrint('----------- ' + data.toString() + ' -----------');
  }
}
