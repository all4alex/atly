import 'package:atly/main.dart';
import 'package:atly/src/presentation/features/home/home_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_text.dart';
import '../pages/message_screen.dart';
import '../sign_up/register_screen.dart';
import '../user_profile/setup_profile_screen.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';
  static const String screenName = 'LoginScreen';

  static ModalRoute route() => MaterialPageRoute(
      builder: (context) => LoginScreen(),
      settings: RouteSettings(name: routeName));

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email = '';
  late LoginCubit loginCubit;
  String? password = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.checkUserAuth();
  }

  void showErrorMessage(BuildContext context) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Opps!',
        message: 'Incorrect email or password.',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          height: screenSize.height,
          width: screenSize.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/splash_cafe_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Color.fromARGB(68, 242, 242, 242),
                border: Border.all(
                  color: Colors.white70,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      HomeScreen.route(menuScreenContext: context));
                } else if (state is LoginFailed) {
                  showErrorMessage(context);
                }
              },
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginCheckingAuth) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/icons/atly_splash_white_icon.png',
                            width: 93.5,
                            height: 93.4,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome to',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                              ),
                              Image.asset(
                                'assets/icons/atly_splash_white_text_icon.png',
                                width: 73.8,
                                height: 50.2,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                child: Text(
                                  'LOG IN',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email can't be empty";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => email = newValue,
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password can't be empty";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => password = newValue,
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerRight,
                                width: double.infinity,
                                child: Text(
                                  'Forgot password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        loginCubit.loginWithEmailAndPassword(
                                            email: email!, password: password!);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        fixedSize: Size(screenSize.width, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    child: state is LoginLoading
                                        ? const CircularProgressIndicator()
                                        : Text('Log In',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontFamily: 'Poppins',
                                                  color: AppColors.appBlue,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                  );
                                },
                              ),
                            ],
                          ),
                          Gap(20),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              'OR',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Gap(10),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text('CONNECT WITH',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontFamily: 'Poppins',
                                      color: AppColors.appOriginalWhite,
                                      fontWeight: FontWeight.bold,
                                    )),
                          ),
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: screenSize.height * .05,
                                      child: GFButton(
                                        onPressed: () {},
                                        shape: GFButtonShape.pills,
                                        color: AppColors.appWhite,
                                        child: Text('Email',
                                            style: AppText.body2.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.iconGrey)),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: SizedBox(
                                      height: screenSize.height * .05,
                                      child: GFButton(
                                        onPressed: () {},
                                        shape: GFButtonShape.pills,
                                        color: Colors.red.shade700,
                                        child: Text('Google+',
                                            style: AppText.body2.copyWith(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: screenSize.height * .05,
                                      child: GFButton(
                                        onPressed: () {},
                                        shape: GFButtonShape.pills,
                                        child: Text('Facebook',
                                            style: AppText.body2.copyWith(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: SizedBox(
                                      height: screenSize.height * .05,
                                      child: GFButton(
                                        onPressed: () {},
                                        shape: GFButtonShape.pills,
                                        color: AppColors.appWhite,
                                        child: Text('Apple',
                                            style: AppText.body2.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.appBlack)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NEW HERE?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontFamily: 'Poppins',
                                        color: AppColors.appOriginalWhite,
                                        fontWeight: FontWeight.bold,
                                      )),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(RegisterScreen.route());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    fixedSize: Size(screenSize.width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                child: Text('Create Account',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontFamily: 'Poppins',
                                          color: AppColors.appBlue,
                                          fontWeight: FontWeight.bold,
                                        )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
