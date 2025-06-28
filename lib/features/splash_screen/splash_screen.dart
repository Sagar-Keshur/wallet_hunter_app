import 'package:flutter/material.dart';

import '../../core/style_guide/style_guide.dart';
import '../../core/utils/context_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.splash,
        fit: BoxFit.cover,
        height: context.height,
        width: context.width,
      ),
    );
  }
}
