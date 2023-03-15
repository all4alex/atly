import 'package:flutter/material.dart';

class AtlyScaffold extends StatelessWidget {
  AtlyScaffold({
    this.appBar,
    this.body,
    this.appBarHeight,
    this.bottomSheet,
    this.floatingActionButton,
    this.backgroundColor = Colors.white,
    this.bodyHeight,
  });
  final Widget? appBar;
  final Widget? body;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;

  final double? appBarHeight;
  final Color backgroundColor;
  final double? bodyHeight;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      top: appBarHeight ?? screenSize.height * .14),
                  height: bodyHeight ?? screenSize.height,
                  width: screenSize.width,
                  child: body ?? const SizedBox()),
            ),
            appBar ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
