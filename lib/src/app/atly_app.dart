import 'package:atly/src/presentation/features/sign_up/register_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:atly/src/presentation/features/login/login_screen.dart';
import 'package:atly/src/presentation/features/user_profile/cubit/profile_cubit.dart';

import '../presentation/features/login/cubit/login_cubit.dart';
import '../presentation/features/sign_up/cubit/register_cubit.dart';
import '../presentation/features/user_profile/setup_profile_screen.dart';
import 'app_colors.dart';

class AtlyApp extends StatefulWidget {
  AtlyApp({super.key});

  @override
  State<AtlyApp> createState() => _AtlyAppState();
}

class _AtlyAppState extends State<AtlyApp> {
  final LoginCubit _loginCubit = LoginCubit();

  final RegisterCubit _registerCubit = RegisterCubit();

  final ProfileCubit _profileCubit = ProfileCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.appWhite,
      ),
      darkTheme: ThemeData.dark(),
      routes: {
        '/': (context) => BlocProvider.value(
              value: _loginCubit,
              child: LoginScreen(),
            ),
        '/signup': (context) => BlocProvider.value(
              value: _registerCubit,
              child: RegisterScreen(),
            ),
        '/profile-setup': (context) => BlocProvider.value(
              value: _profileCubit,
              child: SetupProfileScreen(),
            ),
      },
    );
  }

  @override
  void dispose() {
    _loginCubit.close();
    _registerCubit.close();
    _profileCubit.close();
    super.dispose();
  }
}
