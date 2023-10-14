import 'package:flutter/material.dart';
import 'package:flutter_animations_2/main.dart';
import 'package:flutter_animations_2/material3/segment_and_badge_button_class.dart';
import 'package:flutter_animations_2/nft_pages/nft_home_screen.dart';

abstract class RoutingWithName {

  static Map<String, WidgetBuilder> routes() => {
        "/": (context) => const MainApp(),
        '/nft_home_screen': (context) => const NftHomeScreen(),
        "/segment_button_page": (context) => const SegmentButtonClass()
      };
}
