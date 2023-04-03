import 'package:atly/main.dart';
import 'package:atly/src/app/app_loader.dart';
import 'package:atly/src/app/app_strings.dart';
import 'package:atly/src/app/app_svg_icons.dart';
import 'package:atly/src/app/app_text.dart';
import 'package:atly/src/data/models/user_profile_model.dart';
import 'package:atly/src/data/services/remote/user_service.dart';
import 'package:atly/src/presentation/features/login/cubit/login_cubit.dart';
import 'package:atly/src/presentation/features/login/login_screen.dart';
import 'package:atly/src/presentation/features/pages/callendar_screen.dart';
import 'package:atly/src/presentation/features/pages/cubit/chat_cubit.dart';
import 'package:atly/src/presentation/features/pages/dashboard_screen.dart';
import 'package:atly/src/presentation/features/pages/messages_list_screen.dart';
import 'package:atly/src/presentation/features/pages/modals/bottom_modal/add_message_modal.dart';
import 'package:atly/src/presentation/features/pages/modals/bottom_modal/nav_add_modal.dart';
import 'package:atly/src/presentation/features/user_profile/cubit/profile_cubit.dart';
import 'package:atly/src/presentation/features/user_profile/setup_profile_screen.dart';
import 'package:atly/src/presentation/widgets/cubit/appbar_subtitle_cubit.dart';
import 'package:atly/src/presentation/widgets/nav_speed_dial.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../app/app_colors.dart';
import '../../widgets/atly_appbar_subtitle.dart';
import '../../widgets/bx_scaffold.dart';
import '../pages/add_nav_screen.dart';
import '../pages/friend_list_screen.dart';
import '../pages/message_screen.dart';
import '../pages/notification_screen.dart';
import '../../widgets/atly_appbar.dart';
import 'cubit/cubit/notification_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/main';
  static const String screenName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static ModalRoute<void> route({required BuildContext menuScreenContext}) =>
      MaterialPageRoute<void>(
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => LoginCubit(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        ProfileCubit(userService: UserServiceImpl()),
                  ),
                  BlocProvider(
                    create: (context) => AppbarSubtitleCubit(),
                  ),
                  BlocProvider(
                    create: (context) => NotificationCubit(),
                  ),
                ],
                child: HomeScreen(),
              ),
          settings: RouteSettings(name: routeName));
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfileModel userProfileModel = UserProfileModel();
  late PersistentTabController _controller;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late ProfileCubit profileCubit;
  String appBarSubtitle = '';
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    profileCubit.getUserProfile();
    BlocProvider.of<AppbarSubtitleCubit>(context).updateAppbarSubtitle('Home');
  }

  @override
  Widget build(final BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<Widget> _buildScreens() => [
          DashboardScreen(),
          FriendListScreen(),
          HomeAddNavModal(),
          CallendarScreen(),
          NotificationScreen()
        ];

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppSvgAssetLocation.home,
            height: 30,
            width: 30,
            color: AppColors.appBlue,
          ),
          inactiveIcon: SvgPicture.asset(
            AppSvgAssetLocation.home,
            height: 30,
            width: 30,
            color: AppColors.appMainGrey,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppSvgAssetLocation.people,
            height: 30,
            width: 30,
            color: AppColors.appBlue,
          ),
          inactiveIcon: SvgPicture.asset(
            AppSvgAssetLocation.people,
            height: 30,
            width: 30,
            color: AppColors.appMainGrey,
          ),
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
          icon: SvgPicture.asset(
            AppSvgAssetLocation.calendar,
            height: 30,
            width: 30,
            color: AppColors.appBlue,
          ),
          inactiveIcon: SvgPicture.asset(
            AppSvgAssetLocation.calendar,
            height: 30,
            width: 30,
            color: AppColors.appMainGrey,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            AppSvgAssetLocation.bell,
            height: 30,
            width: 30,
            color: AppColors.appBlue,
          ),
          inactiveIcon: SvgPicture.asset(
            AppSvgAssetLocation.bell,
            height: 30,
            width: 30,
            color: AppColors.appMainGrey,
          ),
        ),
      ];
    }

    void _showBottomModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GFButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print('Event button pressed');
                  },
                  text: 'Event',
                  shape: GFButtonShape.pills,
                ),
                SizedBox(height: 8),
                GFButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print('Pitch button pressed');
                  },
                  text: 'Pitch',
                  shape: GFButtonShape.pills,
                ),
                SizedBox(height: 8),
                GFButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print('Message button pressed');
                  },
                  text: 'Message',
                  shape: GFButtonShape.pills,
                ),
              ],
            ),
          );
        },
      );
    }

    void _showBottomDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return BottomDialog();
        },
      );
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacement(LoginScreen.route());
            }
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailed) {
              pushNewScreenWithRouteSettings(
                context,
                settings: RouteSettings(name: SetupProfileScreen.routeName),
                screen: BlocProvider.value(
                  value: profileCubit,
                  child: SetupProfileScreen(),
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            }
            if (state is SaveProfileSuccess) {
              profileCubit.getUserProfile();
            }
          },
        ),
      ],
      child: Scaffold(
          key: _key,
          backgroundColor: AppColors.appBlue,
          drawerEnableOpenDragGesture: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            width: 60,
            height: 60,
            child: GFButton(
                onPressed: () => _showBottomDialog(context),
                child: Icon(
                  Icons.add,
                  color: AppColors.appGrey,
                  size: 35,
                ),
                color: AppColors.appOriginalWhite,
                boxShadow: BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 5  horizontally
                    3.0, // Move to bottom 5 Vertically
                  ),
                ),
                shape: GFButtonShape.pills),

            //  NavSpeedDial(
            //   onBlast: () {},
            //   onEvent: () {},
            //   onMessage: () async {
            //     await showCupertinoModalBottomSheet(
            //       context: context,
            //       useRootNavigator: true,
            //       overlayStyle: SystemUiOverlayStyle(),
            //       backgroundColor: Colors.transparent,
            //       builder: (context) => BlocProvider(
            //         create: (context) => ChatCubit(),
            //         child: AddMessageModal(),
            //       ),
            //     ).then((value) {
            //       if (value != null) {
            //         showCupertinoModalBottomSheet(
            //             context: context,
            //             useRootNavigator: true,
            //             overlayStyle: SystemUiOverlayStyle(),
            //             builder: (context) => MessageScreen(room: value));
            //       }
            //       return;
            //     });
            //   },
            //   onPitch: () {},
            //   onToss: () {},
            // ),
          ),
          drawer: GFDrawer(
            child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
              if (state is ProfileSuccess) {
                userProfileModel = state.userProfileModel;
              }
              return Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    height: size.height * .35,
                    child: Column(
                      children: [
                        Gap(40),
                        Image.asset(
                          'assets/icons/atly_text_logo.png',
                          height: size.height * .04,
                          fit: BoxFit.fitHeight,
                        ),
                        Gap(10),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: CachedNetworkImageProvider(
                              'https://i.pravatar.cc/300'),
                          radius: 30,
                        ),
                        Gap(10),
                        Text(
                          '${userProfileModel.firstName} ${userProfileModel.lastName}',
                          style: AppText.subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${userProfileModel.contactNumber}',
                          style: AppText.caption
                              .copyWith(color: AppColors.appBlue),
                        ),
                        Gap(15),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Text(
                              AppString.generateQr,
                              style: AppText.button.copyWith(fontSize: 10),
                            ),
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ListTile(
                          title: Text(AppString.accountsAndProfile,
                              style: AppText.subtitle2.copyWith(
                                color: AppColors.appGrey,
                              )),
                          onTap: null,
                        ),
                        ListTile(
                          title: Text(AppString.settings,
                              style: AppText.subtitle2.copyWith(
                                color: AppColors.appGrey,
                              )),
                          onTap: null,
                        ),
                        Gap(20),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state is LogoutLoading) {
                              return AppLoader.loaderOne;
                            }
                            return ListTile(
                              title: Text(AppString.logout,
                                  style: AppText.subtitle2.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.appPink,
                                  )),
                              onTap: () {
                                context.read<LoginCubit>().logout();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Stack(
                children: <Widget>[
                  PersistentTabView(
                    context,
                    controller: _controller,
                    onItemSelected: (value) {
                      switch (value) {
                        case 1:
                          BlocProvider.of<AppbarSubtitleCubit>(context)
                              .updateAppbarSubtitle('Friends');
                          break;
                        case 2:
                          BlocProvider.of<AppbarSubtitleCubit>(context)
                              .updateAppbarSubtitle('');
                          break;
                        case 3:
                          BlocProvider.of<AppbarSubtitleCubit>(context)
                              .updateAppbarSubtitle('Callendar');
                          break;
                        case 4:
                          BlocProvider.of<AppbarSubtitleCubit>(context)
                              .updateAppbarSubtitle('Notification');
                          break;
                        default:
                          BlocProvider.of<AppbarSubtitleCubit>(context)
                              .updateAppbarSubtitle('Home');
                      }
                    },
                    screens: _buildScreens(),
                    items: _navBarsItems(),
                    confineInSafeArea: true,
                    backgroundColor: Colors.white, // Default is Colors.white.
                    handleAndroidBackButtonPress: true, // Default is true.
                    resizeToAvoidBottomInset:
                        true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                    selectedTabScreenContext: (p0) {
                      selectedTabScreenContext = p0;
                    },
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
                    // screenTransitionAnimation: ScreenTransitionAnimation(
                    //   // Screen transition animation on change of selected tab.
                    //   animateTabTransition: true,
                    //   curve: Curves.ease,
                    //   duration: Duration(milliseconds: 10),
                    // ),
                    navBarStyle: NavBarStyle
                        .style15, // Choose the nav bar style with this property.
                  ),
                  BlocBuilder<AppbarSubtitleCubit, String>(
                    builder: (_, state) {
                      return AtlyAppbar(
                        inverted: state == 'Home',
                        onAction1: () {
                          _key.currentState!.openDrawer();
                        },
                        onAction2: () {},
                        subtitle: state == 'Home'
                            ? null
                            : AtlyAppbarSubtitle(subtitle: state),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class BottomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: GFButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print('Event button pressed');
                  },
                  text: 'Event',
                  shape: GFButtonShape.pills,
                  color: AppColors.appBlue,
                  textStyle:
                      AppText.button.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Gap(12),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: GFButton(
                    onPressed: () {
                      Navigator.pop(context);
                      print('Pitch button pressed');
                    },
                    text: 'Pitch',
                    shape: GFButtonShape.pills,
                    color: AppColors.appPink,
                    textStyle:
                        AppText.button.copyWith(fontWeight: FontWeight.bold)),
              ),
              Gap(12),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.1,
                child: GFButton(
                    onPressed: () async {
                      await showCupertinoModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        overlayStyle: SystemUiOverlayStyle(),
                        backgroundColor: Colors.transparent,
                        builder: (context) => BlocProvider(
                          create: (context) => ChatCubit(),
                          child: AddMessageModal(),
                        ),
                      ).then((value) {
                        if (value != null) {
                          showCupertinoModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              overlayStyle: SystemUiOverlayStyle(),
                              builder: (context) => MessageScreen(room: value));
                        }
                        return;
                      });
                    },
                    text: 'Message',
                    shape: GFButtonShape.pills,
                    color: AppColors.appWhite,
                    textStyle: AppText.button.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.iconBlue,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
