import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/platform_widgets/platform_helper.dart';
import 'package:intersperse/intersperse.dart';

enum RadioCheckerEnum {
  russia,
  romania,
  america,
  brazil,
}

class PlatformRadio extends StatefulWidget {
  const PlatformRadio({super.key});

  @override
  State<PlatformRadio> createState() => _PlatformRadioState();
}

class _PlatformRadioState extends State<PlatformRadio> {
  RadioCheckerEnum radio = RadioCheckerEnum.russia;

  @override
  Widget build(BuildContext context) {
    return PlatformHelper.isCupertino()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoListSection(
                children: RadioCheckerEnum.values
                    .map(
                      (element) => Column(
                        children: [
                          SizedBox(height: 10),
                          CupertinoRadio(
                            value: element,
                            groupValue: radio,
                            onChanged: (value) {
                              setState(() {
                                radio = element;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          )
        : CupertinoListSection(
            children: RadioCheckerEnum.values
                .map(
                  (element) => Radio(
                    value: element,
                    groupValue: radio,
                    onChanged: (v) {
                      setState(() {
                        radio = element;
                      });
                    },
                  ),
                )
                .toList(),
          );
  }
}
