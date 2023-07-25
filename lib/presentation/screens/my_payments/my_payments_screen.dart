import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';

class MyPaymentsScreen extends StatelessWidget {
  const MyPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
    );
  }
}
