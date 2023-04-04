import 'package:flutter/material.dart';

import '../../app/app.dart';

class AtlyNameAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;

  const AtlyNameAvatar({
    Key? key,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameAvatar = firstName.split('')[0].toUpperCase() +
        lastName.split('')[0].toUpperCase();
    return CircleAvatar(
      backgroundColor: AppColors.appWhite,
      radius: 25,
      child: Text(
        nameAvatar,
        style: const TextStyle(color: AppColors.appGrey),
      ),
    );
  }
}
