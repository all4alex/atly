import 'package:atly/src/data/services/api/user_service.dart';
import 'package:atly/src/data/services/local/local_storage_service.dart';
import 'package:atly/src/presentation/features/sign_up/register_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:atly/src/presentation/features/login/login_screen.dart';
import 'package:atly/src/presentation/features/user_profile/cubit/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/features/home/home_screen.dart';
import '../presentation/features/login/cubit/login_cubit.dart';
import '../presentation/features/sign_up/cubit/register_cubit.dart';
import '../presentation/features/user_profile/setup_profile_screen.dart';
import 'app_colors.dart';

late User? currentUser;

class AtlyApp extends StatefulWidget {
  AtlyApp({super.key});

  @override
  State<AtlyApp> createState() => _AtlyAppState();
}

class _AtlyAppState extends State<AtlyApp> {
  final LoginCubit _loginCubit = LoginCubit();

  final RegisterCubit _registerCubit =
      RegisterCubit(userService: UserServiceImpl());

  final ProfileCubit _profileCubit =
      ProfileCubit(userService: UserServiceImpl());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // LocalStorage().updateSession(user: snapshot.data);
            currentUser = snapshot.data;
          }
          return MaterialApp(
            title: 'Atly',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Outfit'),
            locale: DevicePreview.locale(context),
            routes: {
              '/': (context) => BlocProvider.value(
                    value: _loginCubit,
                    child: LoginScreen(),
                  ),
              '/signup': (context) => BlocProvider.value(
                    value: _registerCubit,
                    child: RegisterScreen(),
                  ),
            },
          );
        });
  }

  @override
  void dispose() {
    _loginCubit.close();
    _registerCubit.close();
    _profileCubit.close();
    super.dispose();
  }
}
