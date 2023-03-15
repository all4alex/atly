import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appWhite,
      child: Center(
        child: Text('NotificationScreen'),
      ),
    );
  }
}
