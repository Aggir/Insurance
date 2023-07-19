import 'package:flutter/material.dart';

class FormScaffold extends StatelessWidget {
  const FormScaffold({required this.body, this.appBar, super.key});
  final Widget body;
  final AppBar? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: body),
    );
  }
}
