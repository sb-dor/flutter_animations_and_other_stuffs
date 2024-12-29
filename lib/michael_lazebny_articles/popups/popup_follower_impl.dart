// To avoid writing all this stuff every time you create a new popup, Michael Lazebny developed a widget called
// PopupFollower that includes "shortcut and action" features and a few more (optional dismissing on screen resize
// and on scrolling).

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/popups/widgets/popup.dart';

class PopupFollowerImpl extends StatefulWidget {
  const PopupFollowerImpl({super.key});

  @override
  State<PopupFollowerImpl> createState() => _PopupFollowerState();
}

class _PopupFollowerState extends State<PopupFollowerImpl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popup widgets with shortcuts with PopupFollower widget",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Popup(
              follower: (context, controller) => PopupFollower(
                tapRegionGroupId: controller,
                onDismiss: controller.hide,
                child: IntrinsicWidth(
                  child: Card(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            25,
                            (index) => ListTile(
                              title: const Text('Item 1'),
                              onTap: controller.hide,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              child: (context, controller) => FilledButton(
                onPressed: () {
                  controller.show();
                },
                child: Text(
                  "Show simple popup",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
