import 'package:atly/app/app_colors.dart';
import 'package:atly/logic/cubit/cubit/profile_cubit.dart';
import 'package:atly/logic/cubit/register/register_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/login/login_cubit.dart';
import '../presentation/screens/login_screen.dart';

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
