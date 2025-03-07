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

  List<Widget> get createdWidgets => _widgets;

  int index = 0;

  void increment() {
    index++;
    setState(() {});
  }

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
  const _VisibilityAnimatedWidget();

  @override
  State<_VisibilityAnimatedWidget> createState() =>
      _VisibilityAnimatedWidgetState();
}

class _VisibilityAnimatedWidgetState extends State<_VisibilityAnimatedWidget> {
  final _widgetId = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    final findAncestor =
        context.findRootAncestorStateOfType<_AnimatedWidgetDetectorState>();
    return VisibilityDetector(
      key: ValueKey(_widgetId),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 20) {
          debugPrint(
              'Widget ${visibilityInfo.key} is $visiblePercentage% visible $_widgetId');
        }

        //// gets first found type of <_AnimatedWidgetDetectorState>
        final a =
            context.findAncestorStateOfType<_AnimatedWidgetDetectorState>();

        // from above created widget
        a?.createdWidgets;

        // gets last found type of <get first type of <_AnimatedWidgetDetectorState>>
        final b =
            context.findRootAncestorStateOfType<_AnimatedWidgetDetectorState>();

        // from above createdWidget
        b?.createdWidgets;
      },
      child: GestureDetector(
        onTap: () {
          findAncestor?.increment();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          color: Colors.red,
          child: Center(
            child: Text((findAncestor?.index ?? '').toString()),
          ),
        ),
      ),
    );
  }
}
//
// extension on BuildContext {
//   T? findNumberAncestorStateOfType<T extends State<StatefulWidget>>(int which) {
//     // assert(_debugCheckStateIsActiveForAncestorLookup());
//     Element? ancestor;
//     StatefulElement? statefulAncestor;
//     while (ancestor != null) {
//       if (ancestor is StatefulElement && ancestor.state is T) {
//         statefulAncestor = ancestor;
//       }
//       ancestor = ancestor;
//     }
//     return statefulAncestor?.state as T?;
//   }
// }
