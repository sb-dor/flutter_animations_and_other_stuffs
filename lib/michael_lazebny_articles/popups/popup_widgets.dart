import 'package:flutter/material.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/popups/widgets/popup.dart';

class PopupWidgets extends StatefulWidget {
  const PopupWidgets({super.key});

  @override
  State<PopupWidgets> createState() => _PopupWidgetsState();
}

class _PopupWidgetsState extends State<PopupWidgets> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ML article about popups",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Popup(
              // about the "TapRegion" :
              // https://api.flutter.dev/flutter/widgets/TapRegion-class.html
              follower: (context, controller) => IntrinsicWidth(
                child: Card(
                  margin: EdgeInsets.zero,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Item 1'),
                          onTap: controller.hide,
                        ),
                        ListTile(
                          title: const Text('Item 2'),
                          onTap: controller.hide,
                        ),
                        ListTile(
                          title: const Text('Item 3'),
                          onTap: controller.hide,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              child: (context, controller) => FilledButton(
                onPressed: () {
                  // if (controller.isShowing) {
                  //   controller.hide();
                  //   return;
                  // }
                  controller.show();
                },
                child: const Text("Show simple popup"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
