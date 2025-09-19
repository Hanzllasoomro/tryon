import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TryOnButton extends StatelessWidget {
  final String skuId;

  const TryOnButton({super.key, required this.skuId});

  Future<void> _openTryOn(String sku) async {
    final url = Uri.parse("https://tryonvirtually.netlify.app/?sku=$sku");

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // external browser
        // agar webview me kholna ho to LaunchMode.inAppWebView
      );
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _openTryOn(skuId),
      child: const Text("Try On Glasses"),
    );
  }
}
