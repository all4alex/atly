import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:atly/src/presentation/features/login/login_screen.dart';
import 'package:atly/src/presentation/features/user_profile/cubit/profile_cubit.dart';

import '../presentation/features/login/cubit/login_cubit.dart';
import '../presentation/features/sign_up/cubit/register_cubit.dart';
import 'app_colors.dart';

class AtlyApp extends StatelessWidget {
  const AtlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),

        BlocProvider(
          create: (context) => RegisterCubit(),
        ),

        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: AppColors.appWhite,
        ),
        darkTheme: ThemeData.dark(),
        home: LoginScreen(),
      ),
    );
  }
}
