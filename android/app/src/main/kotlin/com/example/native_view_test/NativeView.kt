package com.example.native_view_test


import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.TextView
import androidx.lifecycle.*
import com.google.zxing.BarcodeFormat
import com.google.zxing.ResultPoint
import com.journeyapps.barcodescanner.BarcodeCallback
import com.journeyapps.barcodescanner.BarcodeResult
import com.journeyapps.barcodescanner.DecoratedBarcodeView
import com.journeyapps.barcodescanner.DefaultDecoderFactory
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.util.*


class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val textView: TextView
    private val CHANNEL = "flashlight"

    private val rootView: View
    private var barcodeView: DecoratedBarcodeView? = null
    override fun getView(): View {
        return rootView
    }

    override fun dispose() {}

    init {
        (context as LifecycleOwner).lifecycle.addObserver(object : LifecycleObserver {
            @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
            fun onResume() {
                barcodeView?.resume()
            }

            @OnLifecycleEvent(Lifecycle.Event.ON_PAUSE)
            fun onPause() {
                barcodeView?.pause()
            }
        })

        rootView = LayoutInflater.from(context.applicationContext).inflate(R.layout.layout, null)

        barcodeView = rootView.findViewById<DecoratedBarcodeView>(R.id.barcode_scanner)
        val formats: Collection<BarcodeFormat> = Arrays.asList(BarcodeFormat.QR_CODE, BarcodeFormat.CODE_39)
        barcodeView?.barcodeView?.decoderFactory = DefaultDecoderFactory(formats)
        barcodeView?.setStatusText("")
        barcodeView?.viewFinder?.visibility = View.INVISIBLE

        barcodeView?.initializeFromIntent(Intent())
        barcodeView?.decodeContinuous(object : BarcodeCallback {
            override fun possibleResultPoints(resultPoints: MutableList<ResultPoint>?) {
                super.possibleResultPoints(resultPoints)

            }

            override fun barcodeResult(result: BarcodeResult?) {
                (context as ResultCallback).result(result?.result?.text ?: "no result")
                barcodeView?.setStatusText(result?.text)
            }
        })

        barcodeView?.resume()
        textView = TextView(context)
        textView.textSize = 36f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = "Rendered on a native Android view (id: $id) ${creationParams?.entries}"

        val flutterEngine = (context as ResultCallback).getMyFlutterEngine()
        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "onFlash" -> {
                            barcodeView?.setTorchOn()
                            result.success("setTorchOn")
                        }

                        "offFlash" -> {
                            barcodeView?.setTorchOff()
                            result.success("setTorchOff")
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                }
    }
}