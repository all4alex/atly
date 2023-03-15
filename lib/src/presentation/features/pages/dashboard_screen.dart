import 'package:atly/src/app/app_colors.dart';
import 'package:flutter/material.dart';

import '../../widgets/atly_appbar_subtitle.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: Center(
        child: Text('Dashboard Screen'),
      ),
    );
  }
}
