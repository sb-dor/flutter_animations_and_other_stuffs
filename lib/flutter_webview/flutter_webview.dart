import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterWebView extends StatefulWidget {
  const FlutterWebView({Key? key}) : super(key: key);

  @override
  State<FlutterWebView> createState() => _FlutterWebViewState();
}

class _FlutterWebViewState extends State<FlutterWebView> {
  final _key = UniqueKey();
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WebView page")),
      body: WebViewWidget(controller: controller),
    );
  }
}
