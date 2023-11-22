import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/listview_physics/fast_scroll_physics.dart';

typedef WheelRangeController = PageController;

class WheelRangePicker extends StatefulWidget {
  final WheelRangeController? firstWheelRangeController;

  final WheelRangeController? secondWheelRangeController;

  final List<dynamic> listForShow;

  final TextStyle? textStyle;

  final ValueChanged<String> onFirstSliderChange;

  final ValueChanged<String> onSecondSliderChange;

  /// when you put true to this value
  /// automatically will be set "START_INDEX" in list
  final bool startValue;

  final String? firstStartValue;

  final String? secondStartValue;

  const WheelRangePicker({
    Key? key,
    required this.listForShow,
    required this.onFirstSliderChange,
    required this.onSecondSliderChange,
    this.firstWheelRangeController,
    this.secondWheelRangeController,
    this.textStyle,
    this.startValue = false,
    this.firstStartValue,
    this.secondStartValue,
  }) : super(key: key);

  @override
  State<WheelRangePicker> createState() => _WheelRangePickerState();
}

class _WheelRangePickerState extends State<WheelRangePicker> {
  late List<dynamic> slideList;
  late WheelRangeController _firstWheelController;
  late WheelRangeController _secondWheelController;
  int _firstScrollIndex = 0;
  int _secondScrollIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    slideList = widget.listForShow.isEmpty
        ? List<dynamic>.generate((100 ~/ 10) + 1, (index) {
            if (index == 0) {
              return 1;
            } else {
              return index * 10;
            }
          }).toList()
        : List<dynamic>.from(widget.listForShow);

    if (widget.startValue) {
      slideList.insert(0, "START_INDEX");
    }

    _firstWheelController = widget.firstWheelRangeController ??
        PageController(
          viewportFraction: 0.450,
          initialPage: pow(10, 3).toInt() + 1,
        );

    _secondWheelController = widget.secondWheelRangeController ??
        PageController(
          viewportFraction: 0.450,
          initialPage: pow(10, 3).toInt() + 1,
        );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _firstScrollIndex = (_firstWheelController.initialPage + 1) % slideList.length;

        _secondScrollIndex = (_secondWheelController.initialPage + 1) % slideList.length;

        _firstWheelController.jumpToPage(_firstWheelController.initialPage - _firstScrollIndex);

        _secondWheelController.jumpToPage(_secondWheelController.initialPage - _secondScrollIndex);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Row(children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  onPageChanged: (int index) {
                    try {
                      widget.onFirstSliderChange(
                          slideList[(index % slideList.length) + 1].toString());
                      _firstScrollIndex = (index % slideList.length) + 1;
                    } catch (e) {
                      _firstScrollIndex = 0;
                      widget.onFirstSliderChange(slideList[0].toString());
                    }
                    setState(() {});
                  },
                  padEnds: false,
                  scrollDirection: Axis.vertical,
                  controller: _firstWheelController,
                  physics: const FastScrollPhysics(),
                  itemBuilder: (context, index) {
                    var number = slideList[index % slideList.length];
                    if (number is! String) {
                      return AnimatedDefaultTextStyle(
                        style: widget.textStyle ??
                            TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.9,
                                color: index % slideList.length == _firstScrollIndex
                                    ? Theme.of(context).textTheme.bodySmall?.color
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color
                                        ?.withOpacity(0.3)),
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _WidgetFunctions.separateNumbers(number: number),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (number == "START_INDEX") {
                      return AnimatedDefaultTextStyle(
                        style: widget.textStyle ??
                            TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.9,
                                color: index % slideList.length == _firstScrollIndex
                                    ? Theme.of(context).textTheme.bodySmall?.color
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color
                                        ?.withOpacity(0.3)),
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          widget.firstStartValue ?? "From",
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const Positioned.fill(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Divider(height: 0),
                    SizedBox(height: 40),
                    Divider(height: 0),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
              child: Stack(
            children: [
              PageView.builder(
                onPageChanged: (index) {
                  try {
                    widget
                        .onSecondSliderChange(slideList[(index % slideList.length) + 1].toString());
                    _secondScrollIndex = (index % slideList.length) + 1;
                  } catch (e) {
                    _secondScrollIndex = 0;
                    widget.onSecondSliderChange(slideList[0].toString());
                  }
                  setState(() {});
                },
                // pageSnapping: true,
                padEnds: false,
                scrollDirection: Axis.vertical,
                controller: _secondWheelController,
                // itemCount: autoSearchParameterData.listRangeOfMileage().length,
                physics: const FastScrollPhysics(),
                itemBuilder: (context, index) {
                  var number = slideList[index % slideList.length];
                  if (number is! String) {
                    return AnimatedDefaultTextStyle(
                      style: widget.textStyle ??
                          TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.9,
                              color: index % slideList.length == _secondScrollIndex
                                  ? Theme.of(context).textTheme.bodySmall?.color
                                  : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3)),
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        _WidgetFunctions.separateNumbers(number: number),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (number == "START_INDEX") {
                    return AnimatedDefaultTextStyle(
                      style: widget.textStyle ??
                          TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.9,
                            color: index % slideList.length == _secondScrollIndex
                                ? Theme.of(context).textTheme.bodySmall?.color
                                : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3),
                          ),
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        widget.secondStartValue ?? "To",
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Divider(height: 0),
                    SizedBox(height: 40),
                    Divider(height: 0),
                  ],
                ),
              ),
            ],
          )),
        ]));
  }
}

class _WidgetFunctions {
  static String separateNumbers({num? number}) {
    if (number == null) return "";
    String numberToString = number.toString();
    List<String> chars = [];
    int counter = 0;
    for (int i = numberToString.length - 1; i >= 0; i--) {
      String char = numberToString[i];
      if (char == ' ') continue;
      if (counter < 2) {
        if (char == ',') {
          chars.insert(0, '.');
        } else {
          chars.insert(0, char);
        }
        counter++;
        continue;
      }
      counter = 0;
      chars.insert(0, " $char");
    }
    if (chars.isEmpty) return "";
    return chars.fold<String>('', (preV, el) => preV + el).trim();
  }
}
