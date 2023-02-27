import 'package:atly/logic/cubit/login/cubit/login_cubit.dart';
import 'package:atly/presentation/router/app_router.dart';
import 'package:atly/presentation/screens/home_screen/home_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email = '';
  String? password = '';
  late LoginCubit loginCubit;
  @override
  void didChangeDependencies() {
    loginCubit = BlocProvider.of<LoginCubit>(context);
    super.didChangeDependencies();
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrounds/splash_cafe_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100.0),
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text(
                            'Log In',
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        BlocListener<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              context.go('/home');
                            } else if (state is LoginFailed) {
                              showErrorMessage(context);
                            }
                          },
                          child: BlocBuilder<LoginCubit, LoginState>(
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
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      'OR',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    children: [
                      SignInButton(
                        Buttons.Email,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Google,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Apple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
