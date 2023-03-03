import 'package:atly/app/app_colors.dart';
import 'package:flutter/material.dart';

class AtlyAppbar extends StatelessWidget {
  const AtlyAppbar({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.appScreenBackgroundGrey,
      height: size.height * .15,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.iconBlue,
                      ),
                      onPressed: () {},
                    ),
                    Container(
                        width: size.width * .15,
                        child: Image.asset('assets/icons/atly_text_logo.png')),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      color: AppColors.iconBlue,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chat_rounded,
                        color: AppColors.iconBlue,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: size.width * .05,
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.bottomLeft,
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontFamily: 'Poppins',
                    color: AppColors.iconBlue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
