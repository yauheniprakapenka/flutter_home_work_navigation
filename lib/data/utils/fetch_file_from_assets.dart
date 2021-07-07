import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) async {
  return await rootBundle.loadString(assetsPath).then((file) => file);
}



