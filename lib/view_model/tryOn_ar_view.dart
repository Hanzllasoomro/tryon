import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';

class TryOnArView extends StatefulWidget {
  @override
  _TryOnArViewState createState() => _TryOnArViewState();
}

class _TryOnArViewState extends State<TryOnArView> {
  late DeepArController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DeepArController();
    _initializeDeepAr();
  }

  Future<void> _initializeDeepAr() async {
    await _controller.initialize(
      androidLicenseKey: '50d983dbef5c353680edf72212e3f4ed97da6e8b3aa7e0dfe86b9a2d97540e8ea8494e87e54efdbc',
      iosLicenseKey: '50d983dbef5c353680edf72212e3f4ed97da6e8b3aa7e0dfe86b9a2d97540e8ea8494e87e54efdbc',
      resolution: Resolution.high,
    );
    setState(() {});
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.isInitialized
          ? DeepArPreview(_controller)
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter),
        onPressed: () {
          // Example to load a filter file from assets
          _controller.switchEffect('assets/filters/sunglasses.effect');
        },
      ),
    );
  }
}
