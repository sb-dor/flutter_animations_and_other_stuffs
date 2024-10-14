import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedWidgetDetector extends StatefulWidget {
  const AnimatedWidgetDetector({super.key});

  @override
  State<AnimatedWidgetDetector> createState() => _AnimatedWidgetDetectorState();
}

class _AnimatedWidgetDetectorState extends State<AnimatedWidgetDetector> {
  late final List<Widget> _widgets;

  @override
  void initState() {
    super.initState();

    _widgets = List.generate(
      30,
      (index) => const _VisibilityAnimatedWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated widget detector"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 1000,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _widgets.length,
            itemBuilder: (context, index) {
              return _widgets[index];
            },
          ),
        ],
      ),
    );
  }
}

class _VisibilityAnimatedWidget extends StatefulWidget {
  const _VisibilityAnimatedWidget({super.key});

  @override
  State<_VisibilityAnimatedWidget> createState() => _VisibilityAnimatedWidgetState();
}

class _VisibilityAnimatedWidgetState extends State<_VisibilityAnimatedWidget> {
  final _widgetId = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(_widgetId),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 20) {
          debugPrint('Widget ${visibilityInfo.key} is ${visiblePercentage}% visible $_widgetId');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
