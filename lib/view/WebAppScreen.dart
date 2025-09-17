import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebAppScreen extends StatefulWidget {
  const WebAppScreen({Key? key}) : super(key: key);

  @override
  State<WebAppScreen> createState() => _WebAppScreenState();
}

class _WebAppScreenState extends State<WebAppScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // enable JS
      ..loadRequest(Uri.parse("https://tryonvirtually.netlify.app/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Virtual Try-On")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
