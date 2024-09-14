import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// more about shortcuts you can find here on docs:
// https://api.flutter.dev/flutter/widgets/Shortcuts-class.html
class FlutterShortcuts extends StatefulWidget {
  const FlutterShortcuts({super.key});

  @override
  State<FlutterShortcuts> createState() => _FlutterShortcutsState();
}

class _FlutterShortcutsState extends State<FlutterShortcuts> {
  String shortcut = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter shortcuts"),
        centerTitle: false,
      ),
      body: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          // one or more, second parameter is array that takes shortcuts
          LogicalKeySet(
            LogicalKeyboardKey.shiftLeft,
            LogicalKeyboardKey.keyS,
          ): const ShortCutHelper(),

          // single key activator
          const SingleActivator(LogicalKeyboardKey.arrowUp): const ArrowUpButton(),
        },
        child: Actions(
          // this actions parameter will handle the shortcuts
          actions: <Type, Action<Intent>>{
            // there can be a lot of shortcuts actions
            ShortCutHelper: CallbackAction<ShortCutHelper>(
              onInvoke: (ShortCutHelper intent) {
                setState(() {
                  shortcut = "Left shift + button S";
                });
                return null;
              },
            ),

            //
            ArrowUpButton: CallbackAction<ArrowUpButton>(
              onInvoke: (ArrowUpButton intent) {
                setState(() {
                  shortcut = "Arrow up";
                });
                return null;
              },
            ),
          },
          child: Focus(
            autofocus: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    shortcut,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 100),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: const Text(
                              "Test",
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Push",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// name whatever you want
@immutable
class ShortCutHelper extends Intent {
  const ShortCutHelper();
}

@immutable
class ArrowUpButton extends Intent {
  const ArrowUpButton();
}
