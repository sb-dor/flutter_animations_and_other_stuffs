import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/popups/widgets/popup.dart';

class PopupWidgetsWithShortcuts extends StatefulWidget {
  const PopupWidgetsWithShortcuts({super.key});

  @override
  State<PopupWidgetsWithShortcuts> createState() => _PopupWidgetsWithShortcutsState();
}

class _PopupWidgetsWithShortcutsState extends State<PopupWidgetsWithShortcuts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Popup widgets with shortcuts",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Popup(
              follower: (context, controller) => Shortcuts(
                shortcuts: {
                  LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
                },
                child: Actions(
                  actions: {
                    DismissIntent: CallbackAction<DismissIntent>(
                      onInvoke: (_) => controller.hide(),
                    ),
                  },
                  child: FocusScope(
                    autofocus: true,
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
                ),
              ),
              child: (context, controller) => FilledButton(
                onPressed: () {
                  controller.show();
                },
                child: const Text(
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
