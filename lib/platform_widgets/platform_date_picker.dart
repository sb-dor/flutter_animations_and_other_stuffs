import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'platform_helper.dart';

abstract final class PlatformDateTimePicker {
  static Future<void> showPicker(
    BuildContext context, {
    // test only - you can add your own enum
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.dateAndTime,
  }) async {
    if (PlatformHelper.isCupertino()) {
      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return _CupertinoDateTimePicker(
            mode: mode,
          );
        },
      ).then(
        (then) async {
          if (mode == CupertinoDatePickerMode.dateAndTime) {
            await showCupertinoModalPopup(
              context: context,
              builder: (context) => const _CupertinoDateTimePicker(
                mode: CupertinoDatePickerMode.time,
              ),
            );
          }
        },
      );
    } else {
      switch (mode) {
        case CupertinoDatePickerMode.time:
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
        case CupertinoDatePickerMode.date:
          await showDatePicker(
            context: context,
            firstDate: DateTime(2010),
            lastDate: DateTime(2100),
            initialDate: DateTime.now(),
          );
        case CupertinoDatePickerMode.monthYear:
        case CupertinoDatePickerMode.dateAndTime:
          await showDatePicker(
            context: context,
            firstDate: DateTime(2010),
            lastDate: DateTime(2100),
            initialDate: DateTime.now(),
          ).then(
            (value) => showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ),
          );
      }
    }
  }
}

class _CupertinoDateTimePicker extends StatelessWidget {
  final CupertinoDatePickerMode mode;

  const _CupertinoDateTimePicker({
    this.mode = CupertinoDatePickerMode.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6.0),
      // The Bottom margin is provided to align the popup above the system
      // navigation bar.
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // Provide a background color for the popup.
      color: CupertinoColors.systemBackground.resolveFrom(context),
      // Use a SafeArea widget to avoid system overlaps.
      child: SafeArea(
        top: false,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: mode,
          use24hFormat: true,
          // This shows day of week alongside day of month
          showDayOfWeek: true,
          // This is called when the user changes the date.
          onDateTimeChanged: (DateTime newDate) {
            // setState(() => date = newDate);
          },
        ),
      ),
    );
  }
}
