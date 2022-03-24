import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  const PlatformWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Widget view;
    if (defaultTargetPlatform == TargetPlatform.android) {
      view = AndroidView(
        viewType: 'INTEGRATION_ANDROID',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      view = UiKitView(viewType: 'INTEGRATION_IOS');
    } else {
      view = Text('$defaultTargetPlatform not supported');
    }
    return SizedBox(width: 200, height: 50, child: view);
  }

  void _onPlatformViewCreated(int id) {
    print('platform view created');
  }
}
