import 'package:atly/src/app/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserListItem extends StatefulWidget {
  const UserListItem({
    super.key,
    required this.chatUser,
    required this.onChange,
  });

  final types.User chatUser;
  final Function(bool, types.User) onChange;

  @override
  State<UserListItem> createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: EdgeInsets.only(right: 16),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: widget.chatUser.imageUrl != null
              ? CachedNetworkImageProvider(widget.chatUser.imageUrl!)
              : null,
          radius: 20,
        ),
      ),
      title: Text(
        '${widget.chatUser.firstName} ${widget.chatUser.lastName}',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
      ),
      trailing: GFCheckbox(
        size: GFSize.SMALL,
        activeBgColor: AppColors.appOrange,
        type: GFCheckboxType.circle,
        onChanged: (value) {
          setState(() {
            isChecked = value;
          });
          widget.onChange(isChecked, widget.chatUser);
        },
        value: isChecked,
        inactiveIcon: null,
      ),
    );
  }
}
