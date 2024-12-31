import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animations_2/michael_lazebny_articles/popups/widgets/popup.dart';

class CustomToolTipImpl extends StatefulWidget {
  const CustomToolTipImpl({super.key});

  @override
  State<CustomToolTipImpl> createState() => _CustomToolTipImplState();
}

class _CustomToolTipImplState extends State<CustomToolTipImpl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom tooltip impl"),
        actions: [
          CustomerTooltip(
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit "
                "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            child: Icon(Icons.info),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomerTooltip(
              content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit "
                  "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              child: Icon(Icons.info),
            ),
            Semantics(
              label: 'Add to cart',
              button: true,
              child: Icon(Icons.add_shopping_cart),
            )
          ],
        ),
      ),
    );
  }
}

class CustomerTooltip extends StatefulWidget {
  final String content;
  final Widget child;
  final Duration? animationDuration;

  const CustomerTooltip({
    super.key,
    required this.content,
    required this.child,
     this.animationDuration,
  });

  @override
  State<CustomerTooltip> createState() => _CustomerTooltipState();
}

class _CustomerTooltipState extends State<CustomerTooltip> with SingleTickerProviderStateMixin {
  final overlayController = OverlayPortalController(debugLabel: 'CustomTooltip');
  late final AnimationController _animationController;

  Duration get _animationDuration => widget.animationDuration ?? Duration(milliseconds: 300);

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomerTooltip oldWidget) {
    if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.duration = _animationDuration;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showPopup([Duration? duration]) {
    overlayController.show();
    _animationController.forward();
    // semantic service is useful to debug and check the widgets
    // more info you can find here:
    // 1. https://api.flutter.dev/flutter/widgets/Semantics-class.html
    // 2. https://stackoverflow.com/questions/51465328/flutter-semantics-explanation
    // and check MaterialApp for semantic debugging application
    SemanticsService.tooltip(widget.content);

    if (duration != null) {
      Future.delayed(duration, _hidePopup).ignore();
    }
  }

  void _hidePopup() {
    _animationController.reverse().whenComplete(overlayController.hide);
  }

  void _togglePopup([Duration? duration]) {
    overlayController.isShowing ? _hidePopup() : _showPopup(duration);
  }

  Widget _buildMobileTooltip(Widget child) => GestureDetector(
        onTap: () => _togglePopup(_animationDuration + const Duration(milliseconds: 5000)),
        child: child,
      );

  Widget _buildDesktopTooltip(Widget child) => MouseRegion(
        onEnter: (_) => _showPopup(),
        onExit: (_) => _hidePopup(),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Popup(
      controller: overlayController,
      follower: (context, controller) => PopupFollower(
        tapRegionGroupId: controller,
        onDismiss: _hidePopup,
        child: FadeTransition(
          opacity: _animationController,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(widget.content),
              ),
            ),
          ),
        ),
      ),
      child: (context, controller) {
        late Widget child;
        final platform = defaultTargetPlatform;
        switch (platform) {
          case TargetPlatform.android:
          case TargetPlatform.iOS:
            child = _buildMobileTooltip(widget.child);
            break;
          case TargetPlatform.fuchsia:
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
            child = _buildDesktopTooltip(widget.child);
            break;
        }

        return Semantics(
          tooltip: widget.content,
          child: TapRegion(
            groupId: controller,
            child: child,
          ),
        );
      },
    );
  }
}
