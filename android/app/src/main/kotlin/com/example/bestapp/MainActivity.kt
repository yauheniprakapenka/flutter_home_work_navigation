package com.example.bestapp

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import kotlin.random.Random

class MainActivity : FlutterActivity() {
    private val eventsChannel = "CALL_EVENTS"
    private val methodChannelId = "CALL_METHOD"
    private val intentName = "EVENTS"
    private val intentMessageId = "CALL"

    private var receiver: BroadcastReceiver? = null
    lateinit var job: Job

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, methodChannelId
        ).setMethodCallHandler { call, result ->
            if (call.method == intentMessageId) {
                result.success(Random.nextInt(0, 100))
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor, eventsChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    val intent = Intent(intentName)
                    receiver = createReceiver(events)
                    applicationContext?.registerReceiver(receiver, IntentFilter(intentName))
                    job = CoroutineScope(Dispatchers.Default).launch {
                        for (i in 1..20) {
                            intent.putExtra(intentMessageId, Random.nextInt(0, 100))
                            applicationContext?.sendBroadcast(intent)
                            delay(1000)

                        }
                    }
                }

                override fun onCancel(arguments: Any?) {
                    job.cancel()
                    receiver = null
                }
            }
        )
    }

    fun createReceiver(events: EventChannel.EventSink): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                events.success(intent?.getIntExtra(intentMessageId, 0))
            }
        }
    }
}
