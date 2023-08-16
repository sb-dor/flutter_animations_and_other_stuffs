import 'package:flutter/material.dart';

class DidChangeAppLifeCirclePage extends StatefulWidget {
  const DidChangeAppLifeCirclePage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Hello")),
        body: const Center(child: Text("App life circle observer page")));
  }
}
