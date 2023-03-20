import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appWhite,
      child: Center(
        child: Text('Friends Screen'),
      ),
    );
  }
}
