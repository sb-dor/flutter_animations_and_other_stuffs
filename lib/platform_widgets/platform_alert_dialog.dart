import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_helper.dart';

abstract final class PlatformAlertDialog {
  static Future<void> showAlertDialog(
    BuildContext context, {
    Widget? title,
    Widget? content,
  }) async {
    if (PlatformHelper.isCupertino()) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return _CupertinoDialog(
            title: title,
            content: content,
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return _MaterialDialog(
            title: title,
            content: content,
          );
        },
      );
    }
  }
}

class _CupertinoDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;

  const _CupertinoDialog({
    this.title,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: [
        // you can use PlatformDialogAction
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDestructiveAction: true,
          child: const Text("Yes"),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDefaultAction: true,
          child: const Text("No"),
        )
      ],
    );
  }
}

class _MaterialDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;

  const _MaterialDialog({
    this.title,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        // you can use PlatformDialogAction
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Text("Yes"),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Text("No"),
        ),
      ],
    );
  }
}
