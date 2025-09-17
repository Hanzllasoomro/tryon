import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenWebAppScreen extends StatelessWidget {
  const OpenWebAppScreen({Key? key}) : super(key: key);

  final String _url = "https://tryonvirtually.netlify.app/";

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(_url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // opens in browser
    )) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Open Virtual Try-On")),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          child: const Text("Open Web App"),
        ),
      ),
    );
  }
}
