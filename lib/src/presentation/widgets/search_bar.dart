import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    this.height,
    this.width,
    this.onChanged,
    this.onEditingComplete,
    this.suffixIcon,
    this.onTapSuffix,
    this.hintText = 'Search for shops & restaurants',
    this.textEditingController,
    this.color = Colors.white,
  });
  final double? height;
  final double? width;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Icon? suffixIcon;
  final Function()? onTapSuffix;
  final String hintText;
  final TextEditingController? textEditingController;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        alignment: Alignment.bottomCenter,
        child: Container(
            height: screenSize.height / 15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.appGrey),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: textEditingController,
                style: TextStyle(
                    color: AppColors.appBlack,
                    fontSize: screenSize.height * 0.02),
                onChanged: (String text) {
                  onChanged!(text);
                },
                onEditingComplete: () {
                  onEditingComplete;
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hintText,
                    labelStyle: TextStyle(
                        color: AppColors.appBlack,
                        fontSize: screenSize.height * 0.02),
                    prefixIcon: Container(
                        child: Icon(Icons.search,
                            size: screenSize.height * 0.025,
                            color: AppColors.appBlue)),
                    suffixIcon: onTapSuffix != null
                        ? IconButton(
                            onPressed: () {
                              onTapSuffix!();
                            },
                            icon: suffixIcon!)
                        : null))));
  }
}
