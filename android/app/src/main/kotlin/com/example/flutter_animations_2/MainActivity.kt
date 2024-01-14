package com.example.flutter_animations_2


import MAP_ID
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.yandex.mapkit.MapKitFactory;
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.view.Gravity
import android.widget.Toast

class MainActivity : FlutterActivity() {
    private val channel: String = "get/flutter/buttery";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {

        //cause of putting this "try-catch" is that after clicking upon the "flutter_background_service" notification
        //yandex map throws an exception

        // the key is already locked and you cannot use it
        try {
            MapKitFactory.setLocale("ru_RU"); // Your preferred language. Not required, defaults to system language
            MapKitFactory.setApiKey(MAP_ID); // Your generated API key
        } catch (_: AssertionError) {

        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, channel
        ).setMethodCallHandler { call, result ->
            // This method is invoked on the main thread.
            // TODO
            if (call.method == "getButteryLevel") {
                var buttery = getBatteryLevel();
                if (buttery != -1) {
                    result.success(buttery);
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else if (call.method == "popupMethod") {
                val myToast = Toast.makeText(applicationContext,
                    "Flutter Android Native Toast",
                    Toast.LENGTH_SHORT)
                myToast.setGravity(Gravity.LEFT, 200, 200)
                myToast.show()
            } else {
                result.notImplemented()
            }
        }

        super.configureFlutterEngine(flutterEngine)
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null, IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE, -1
                )
        }
        return batteryLevel
    }

}


