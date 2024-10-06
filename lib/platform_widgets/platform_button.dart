import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_alert_dialog.dart';
import 'platform_helper.dart';

class PlatformButton extends StatelessWidget {
  const PlatformButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformHelper.isCupertino()
        ? CupertinoButton.filled(
            child: const Text("Button"),
            onPressed: () {
              PlatformAlertDialog.showAlertDialog(
                context,
                title: const Text("Hello for ios devs"),
                content: const Text("Continue"),
              );
            },
          )
        : ElevatedButton(
            onPressed: () {
              PlatformAlertDialog.showAlertDialog(
                context,
                title: const Text("Hello for ios devs"),
                content: const Text("Continue"),
              );
            },
            child: const Text("Button"),
          );
  }
}
