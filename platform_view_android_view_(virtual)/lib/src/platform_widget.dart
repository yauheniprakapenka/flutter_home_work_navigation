import 'package:flutter/material.dart';

import 'service.dart';

class PlatformWidget extends StatelessWidget {
  const PlatformWidget({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return const AndroidView(viewType: PlatformService.integrationAndroid);
  }
}
