import 'package:atly/app/app_colors.dart';
import 'package:atly/presentation/screens/widgets/app_dropdown.dart';
import 'package:atly/presentation/screens/widgets/search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class HomeAddNavModal extends StatefulWidget {
  const HomeAddNavModal({Key? key}) : super(key: key);

  @override
  State<HomeAddNavModal> createState() => _HomeAddNavModalState();
}

class _HomeAddNavModalState extends State<HomeAddNavModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GFFloatingWidget(
      child: GFIconBadge(
          child: GFAvatar(
            size: GFSize.LARGE,
          ),
          counterChild: GFBadge(
            text: '12',
            shape: GFBadgeShape.circle,
          )),
      body: Text('body or any kind of widget here..'),
      verticalPosition: MediaQuery.of(context).size.height * 0.2,
      horizontalPosition: MediaQuery.of(context).size.width * 0.8,
    ));
  }
}

// Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         CupertinoPageScaffold(
//                                             navigationBar:
//                                                 CupertinoNavigationBar(
//                                               middle: Text('New Page'),
//                                             ),
//                                             child: Stack(
//                                               fit: StackFit.expand,
//                                               children: <Widget>[],
//                                             ))));
