import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color(0xff191970),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color(0xff007ba7),
};

class CupertinoSlidingSegmentControl extends StatefulWidget {
  const CupertinoSlidingSegmentControl({super.key});

  @override
  State<CupertinoSlidingSegmentControl> createState() => _CupertinoSlidingSegmentControlState();
}

class _CupertinoSlidingSegmentControlState extends State<CupertinoSlidingSegmentControl> {
  Sky _selectedSegment = Sky.midnight;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<Sky>(
      backgroundColor: CupertinoColors.systemGrey2,
      thumbColor: skyColors[_selectedSegment]!,
      // This represents the currently selected segmented control.
      groupValue: _selectedSegment,
      // Callback that sets the selected segmented control.
      onValueChanged: (Sky? value) {
        if (value != null) {
          setState(() {
            _selectedSegment = value;
          });
        }
      },
      children: const <Sky, Widget>{
        Sky.midnight: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Midnight',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Sky.viridian: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Viridian',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Sky.cerulean: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Cerulean',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      },
    );
  }
}
