package com.example.flutter_animations_2

import android.app.Application
import MAP_YANDEX_ID
import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey(MAP_YANDEX_ID) // Your generated API key
    }
}