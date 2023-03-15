import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class CallendarScreen extends StatelessWidget {
  const CallendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appWhite,
      child: Center(
        child: Text('Callendar Screen'),
      ),
    );
  }
}
