import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/platform_widgets/platform_date_picker.dart';

import 'platform_helper.dart';

class PlatformTextButton extends StatelessWidget {
  const PlatformTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformHelper.isCupertino()
        ? CupertinoButton(
            child: const Text("Text button"),
            onPressed: () {
              PlatformDateTimePicker.showPicker(
                context,
                mode: CupertinoDatePickerMode.dateAndTime,
              );
            },
          )
        : TextButton(
            onPressed: () {
              PlatformDateTimePicker.showPicker(
                context,
                mode: CupertinoDatePickerMode.dateAndTime,
              );
            },
            child: const Text("Text button"),
          );
  }
}
