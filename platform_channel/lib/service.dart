import 'package:flutter/services.dart';

class PlatformService {
  static const methodChannel = MethodChannel('CALL_METHOD');
  static const stream = EventChannel('CALL_EVENTS');

  Future<int> callMethodChannel() async {
    try {
      return await methodChannel.invokeMethod('CALL');
    } on Exception catch (e) {
      print('Failed to get value: $e');
      return 0;
    }
  }

  Stream<int> callEventChannel() => stream.receiveBroadcastStream().map((event) => event as int);
}
