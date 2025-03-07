import 'package:flutter/material.dart';

class DidChangeAppLifeCirclePage extends StatefulWidget {
  const DidChangeAppLifeCirclePage({super.key});

  @override
  State<DidChangeAppLifeCirclePage> createState() => _DidChangeAppLifeCirclePageState();
}

class _DidChangeAppLifeCirclePageState extends State<DidChangeAppLifeCirclePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.paused) {
      debugPrint('paused');
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('resumed');
    } else if (state == AppLifecycleState.inactive) {
      debugPrint('inactive');
    } else if (state == AppLifecycleState.detached) {
      debugPrint('detached');
    }
  }

  // works whenever the widget tree changes or some widget configuration changes
  @override
  void didUpdateWidget(covariant DidChangeAppLifeCirclePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("updating widget");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Hello")),
        body: const Center(child: Text("App life circle observer page")));
  }
}
