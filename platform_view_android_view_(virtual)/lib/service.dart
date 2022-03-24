import 'package:flutter/services.dart';

class PlatformService {
  static const _stream = EventChannel('CALL_EVENTS');
  static const integrationAndroid = 'INTEGRATION_ANDROID';

  const PlatformService();
  
  Stream<int> eventChannel() {
    return _stream.receiveBroadcastStream().map((event) => event as int);
  }
}
