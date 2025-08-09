import 'package:deepar_flutter_plus/deepar_flutter_plus.dart';
import 'package:flutter/material.dart';

class TryOnArView extends StatefulWidget {
  const TryOnArView({Key? key}) : super(key: key);

  @override
  State<TryOnArView> createState() => _TryOnArViewState();
}

class _TryOnArViewState extends State<TryOnArView> {
  late DeepArControllerPlus _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = DeepArControllerPlus();
    _initializeDeepAr();
  }

  Future<void> _initializeDeepAr() async {
    await _controller.initialize(
      androidLicenseKey: '50d983dbef5c353680edf72212e3f4ed97da6e8b3aa7e0dfe86b9a2d97540e8ea8494e87e54efdbc',
      iosLicenseKey: '50d983dbef5c353680edf72212e3f4ed97da6e8b3aa7e0dfe86b9a2d97540e8ea8494e87e54efdbc',
      resolution: Resolution.high,
    );
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    // _controller.dispose(); // properly dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isInitialized
          ? DeepArPreviewPlus(_controller)
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.filter),
        onPressed: () {
          // Load your custom glasses filter from assets
          _controller.switchEffect(
            'assets/filters/Hope.deepar', // <-- replace with your .deepar file
            // slot: 'mask', // slot type: mask, effect, filter
          );
        },
      ),
    );
  }
}
