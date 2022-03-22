package com.example.native_view_test

import io.flutter.embedding.engine.FlutterEngine

interface ResultCallback {
    fun result(result: String)
    fun getMyFlutterEngine(): FlutterEngine?
}