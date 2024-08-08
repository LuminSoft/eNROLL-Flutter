package com.yourcompany.yourproject

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "enroll_plugin"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startEnroll") {
                val json = call.arguments<String>()
                startEnroll(json, result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startEnroll(json: String?, result: MethodChannel.Result) {
        // Implement your enrollment logic here
        try {
            // Example implementation:
            // val enrollmentResult = enrollUser(json)
            // if (enrollmentResult == "success") {
            //     result.success("success")
            // } else {
            //     result.success("error: $enrollmentResult")
            // }

            // Simulate a success response
            result.success("success")
        } catch (e: Exception) {
            result.error("ERROR", "Enrollment failed", e.message)
        }
    }
}
