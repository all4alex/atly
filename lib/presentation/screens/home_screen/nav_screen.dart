import 'dart:io';

import 'package:atly/app/app_colors.dart';
import 'package:atly/main.dart';
import 'package:atly/presentation/screens/pages/callendar_screen.dart';
import 'package:atly/presentation/screens/pages/dashboard_screen.dart';
import 'package:atly/presentation/screens/pages/event_screen.dart';
import 'package:atly/presentation/screens/pages/message_screen.dart';
import 'package:atly/presentation/screens/pages/messages_list_screen.dart';
import 'package:atly/presentation/screens/pages/modals/bottom_modal/add_message_modal.dart';
import 'package:atly/presentation/screens/pages/modals/bottom_modal/nav_add_modal.dart';
import 'package:atly/presentation/screens/pages/modals/samples/circular_modal.dart';
import 'package:atly/presentation/screens/widgets/nav_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../pages/add_nav_screen.dart';
import '../pages/notification_screen.dart';
import '../widgets/atly_appbar.dart';

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
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
          HomeAddNavModal(),
          CallendarScreen(),
          NotificationScreen()
        ];

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.people),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
        PersistentBottomNavBarItem(
            activeColorPrimary: Colors.transparent,
            inactiveColorPrimary: Colors.transparent,
            onPressed: (context) {
              return null;
            },
            icon: Icon(Icons.add)

            // icon: CircleAvatar(
            //   backgroundColor: AppColors.appBlue,
            //   maxRadius: 70,
            //   child: Icon(
            //     Icons.add,
            //     size: 35,
            //     color: Colors.white,
            //   ),
            // ),
            // inactiveIcon: CircleAvatar(
            //   backgroundColor: AppColors.appBlue,
            //   maxRadius: 70,
            //   child: Icon(
            //     Icons.add,
            //     size: 35,
            //     color: Colors.white,
            //   ),
            // )
            ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.calendar),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.userCircle),
          activeColorPrimary: AppColors.iconBlue,
          inactiveColorPrimary: AppColors.iconGrey,
        ),
      ];
    }

    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: NavSpeedDial(
          onBlast: () {},
          onEvent: () {},
          onMessage: () {
            showCupertinoModalBottomSheet(
                context: context,
                useRootNavigator: true,
                overlayStyle: SystemUiOverlayStyle(),
                backgroundColor: Colors.transparent,
                builder: (context) => AddMessageModal());
          },
          onPitch: () {},
          onToss: () {},
        ),
      ),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              currentAccountPicture: GFAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg"),
              ),
              otherAccountsPictures: <Widget>[
                Image(
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg"),
                  fit: BoxFit.cover,
                ),
                GFAvatar(
                  child: Text("ab"),
                )
              ],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('user name'),
                  Text('user@userid.com'),
                ],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: null,
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: null,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          PersistentTabView(
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
            decoration: NavBarDecoration(
                colorBehindNavBar: AppColors.appBlack,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: .2,
                      blurRadius: 10)
                ]),
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
            navBarStyle: NavBarStyle
                .style15, // Choose the nav bar style with this property.
          ),
          AtlyAppbar(
            subtitle: 'Messages',
            onAction1: () {
              _key.currentState!.openDrawer();

              print('clicked action 1');
            },
            onAction2: () {},
            onAction3: () {},
          ),
        ],
      ),
    );
  }
}
