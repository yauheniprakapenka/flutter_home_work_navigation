package com.example.native_view_test

import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel


class MainActivity : FlutterFragmentActivity(), LifecycleOwner, ResultCallback {
    var myEvents: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "qrcodeResultStream")
                .setStreamHandler(object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        myEvents = events
                    }
                    override fun onCancel(arguments: Any?) {
                        myEvents = null
                    }
                })

        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-type>", NativeViewFactory())
    }

    override fun result(result: String) {
        myEvents?.success(result)
    }

    override fun getMyFlutterEngine(): FlutterEngine? = flutterEngine
}
