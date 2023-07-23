import 'package:flutter/material.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          GifAssets.loading,
          height: AppSizes.s150,
          width: AppSizes.s150,
        ),
      ),
    );
  }
}
