import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({Key? key}) : super(key: key);

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    int groupValue = 0;

    return Container(
      child: Column(
        children: [
          GFRadioListTile(
            titleText: 'Arthur Shelby',
            subTitleText: 'By order of the peaky blinders',
            avatar: GFAvatar(
              backgroundImage: AssetImage('Assets image here'),
            ),
            size: 25,
            activeBorderColor: Colors.green,
            focusColor: Colors.green,
            type: GFRadioType.square,
            value: 0,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            inactiveIcon: null,
          ),
          GFRadioListTile(
            titleText: 'Arthur Shelby',
            subTitleText: 'By order of the peaky blinders',
            avatar: GFAvatar(
              backgroundImage: AssetImage('Assets image here'),
            ),
            size: 25,
            activeBorderColor: Colors.green,
            focusColor: Colors.green,
            type: GFRadioType.square,
            value: 1,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            inactiveIcon: null,
          ),
        ],
      ),
    );
  }
}
