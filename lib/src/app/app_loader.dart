import 'package:atly/src/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppLoader {
  static Widget loaderOne = GFLoader(
    type: GFLoaderType.circle,
    loaderColorOne: AppColors.appBlue,
    loaderColorTwo: AppColors.appPink,
    loaderColorThree: AppColors.appYellow,
    duration: Duration(seconds: 1),
  );

  static Widget loaderTwo = GFLoader(
    type: GFLoaderType.circle,
    loaderColorOne: AppColors.appBlue,
    loaderColorTwo: AppColors.appBlue.withOpacity(.6),
    loaderColorThree: AppColors.appBlue.withOpacity(.2),
    duration: Duration(seconds: 1),
  );
}
