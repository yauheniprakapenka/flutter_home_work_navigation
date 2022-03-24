import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "CALL_METHOD", binaryMessenger: controller.binaryMessenger)
        let eventChannel = FlutterEventChannel(name: "CALL_EVENTS", binaryMessenger: controller.binaryMessenger)
        GeneratedPluginRegistrant.register(with: self)
        channel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult) -> Void in 
            guard call.method == "CALL" else {
                result(FlutterMethodNotImplemented)
                return
            }
            result(Int.random(in: 0...100))
        })
        eventChannel.setStreamHandler(StreamHandler())
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

class StreamHandler: NSObject ,FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        var count = 0
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if (count >= 10) {
                    timer.invalidate()
                }
                events(Int.random(in: 0...100))
                count += 1
            }
        } else {
            // Fallback on earlier versions
        }
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
