package com.example.voicecrm

import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "voicecrm/audio"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "setSpeakerphoneOn") {
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                    audioManager.isSpeakerphoneOn = enabled
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }
}
