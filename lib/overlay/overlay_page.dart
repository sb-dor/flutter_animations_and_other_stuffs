import 'package:flutter/material.dart';

class OverlayPage extends StatefulWidget {
  const OverlayPage({super.key});

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  OverlayEntry? overlayEntry;

  void _createAnOverlay() {
    _removeOverlay();

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _removeOverlay(),
                      child:  Container(
                        color: Colors.transparent,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Expanded(
                      child: Text(
                        "<------------------  Tap here to remove overlay",
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () => _createAnOverlay(),
            child: const Text("Open overlay"),
          ),
          Row(
            children: [
              Container(
                color: Colors.pink,
                width: 150,
                height: 150,
              )
            ],
          ),
        ],
      ),
    );
  }
}
