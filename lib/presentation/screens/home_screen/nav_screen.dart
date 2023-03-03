import 'dart:io';

import 'package:atly/app/app_colors.dart';
import 'package:atly/main.dart';
import 'package:atly/presentation/screens/pages/callendar_screen.dart';
import 'package:atly/presentation/screens/pages/dashboard_screen.dart';
import 'package:atly/presentation/screens/pages/event_screen.dart';
import 'package:atly/presentation/screens/pages/message_screen.dart';
import 'package:atly/presentation/screens/pages/messages_list_screen.dart';
import 'package:atly/presentation/screens/pages/modals/bottom_modal/nav_add_modal.dart';
import 'package:atly/presentation/screens/pages/modals/samples/circular_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../pages/add_nav_screen.dart';
import '../pages/notification_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key, required this.menuScreenContext})
      : super(key: key);
  final BuildContext menuScreenContext;
  static const String routeName = '/main';
  static const String screenName = 'NavScreen';
  static ModalRoute<void> route({required BuildContext menuScreenContext}) =>
      MaterialPageRoute<void>(
          builder: (context) => NavScreen(menuScreenContext: menuScreenContext),
          settings: RouteSettings(name: routeName));
  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  late PersistentTabController _controller;
  BuildContext? testContext;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(final BuildContext context) {
    List<Widget> _buildScreens() => [
          DashboardScreen(),
          MessageListScreen(),
          Container(),
          CallendarScreen(),
          NotificationScreen()
        ];

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ('Home'),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.people),
          title: ('Message'),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.add_circle),
          title: ('Add'),
          inactiveColorPrimary: AppColors.iconBlue,
          activeColorPrimary: AppColors.iconBlue,
          activeColorSecondary: AppColors.appWhite,
          iconSize: 40,
          onPressed: (context) {
            return showCupertinoModalBottomSheet(
                context: context!,
                useRootNavigator: true,
                overlayStyle: SystemUiOverlayStyle(),
                backgroundColor: Colors.transparent,
                builder: (context) => HomeAddNavModal());
          },
          inactiveIcon: Icon(Icons.add_circle),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.calendar),
          title: ('Callendar'),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.userCircle),
          title: ('Notification'),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(colorBehindNavBar: Colors.black),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
