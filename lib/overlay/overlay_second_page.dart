import 'package:flutter/material.dart';

class OverlaySecondPage extends StatefulWidget {
  const OverlaySecondPage({super.key});

  @override
  State<OverlaySecondPage> createState() => _OverlaySecondPageState();
}

class _OverlaySecondPageState extends State<OverlaySecondPage> {
  double _alignmentPosition = 0;
  OverlayEntry? _overlayEntry;

  void _openOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
          ),
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment(_alignmentPosition, 0),
                    // color: Colors.amber,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Tap here for",
                          style: TextStyle(color: Colors.blue),
                        ),
                        const Text(
                          "Explore page",
                          style: TextStyle(color: Colors.red),
                        ),
                        const Icon(Icons.arrow_downward),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  void _explore() {
    _alignmentPosition = -1.0;
    setState(() {});
    _openOverlay();
  }

  void _commute() {
    _alignmentPosition = 0.0;
    setState(() {});
    _openOverlay();
  }

  void _saved() {
    _alignmentPosition = 1.0;
    setState(() {});
    _openOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Overlay sample"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "Use Overlay to highlight a NavigationBar destination"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _explore(),
                        child: const Text("Explore"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _commute(),
                        child: const Text("Commute"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _saved(),
                        child: const Text("Saved"),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _removeOverlay(),
                  child: const Text("Remove overlay"),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.deepPurpleAccent.shade100,
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => [],
                          icon: const Icon(
                            Icons.explore,
                            color: Colors.white,
                          ),
                        ),
                        const Text("Explore"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => [],
                          icon: const Icon(
                            Icons.commute,
                            color: Colors.white,
                          ),
                        ),
                        const Text("Commute"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => [],
                          icon: const Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                        ),
                        const Text("Saved"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
