import 'package:atly/src/app/app_colors.dart';
import 'package:flutter/material.dart';

class CallendarScreen extends StatelessWidget {
  const CallendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appOrange,
      body: Container(
        child: Center(
          child: Text('CallendarScreen'),
        ),
      ),
    );
  }
}
