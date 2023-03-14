import 'package:atly/main.dart';
import 'package:atly/src/data/services/api/user_service.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../app/app_colors.dart';
import '../../../app/app_strings.dart';
import '../../../app/app_text.dart';
import '../../../data/models/user_profile_model.dart';
import '../pages/message_screen.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String routeName = '/register';
  static const String screenName = 'RegisterScreen';

  static ModalRoute route({Object? args}) => MaterialPageRoute(
      builder: (context) => BlocProvider(
            create: (context) => RegisterCubit(userService: UserServiceImpl()),
            child: RegisterScreen(),
          ),
      settings: RouteSettings(name: routeName, arguments: args));

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email = '';
  String? password = '';
  late RegisterCubit registerCubit;
  UserProfileModel? userProfileModel;

  @override
  void initState() {
    super.initState();
    registerCubit = BlocProvider.of<RegisterCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void showErrorMessage(BuildContext context, String errorMessage) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Opps!',
        message: errorMessage,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showSuccessToast(BuildContext context, String message) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Succes',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
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
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Color.fromARGB(68, 242, 242, 242),
                  border: Border.all(
                    color: Colors.white70,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: BlocListener<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    showSuccessToast(context, 'Account successfuly created.');
                    Navigator.of(context).pop(state.userCredential);
                  } else if (state is RegisterFailed) {
                    showErrorMessage(context, state.error);
                  }
                },
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
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
                            Gap(30),
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  child: Text(
                                    'CREATE ACCOUNT',
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
                                // const SizedBox(height: 16.0),
                                // TextFormField(
                                //   decoration: InputDecoration(
                                //     hintText: "Username",
                                //     filled: true,
                                //     fillColor: Colors.grey[200],
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(30.0),
                                //       borderSide: BorderSide.none,
                                //     ),
                                //   ),
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return "Email can't be empty";
                                //     }
                                //     return null;
                                //   },
                                //   onSaved: (newValue) => email = newValue,
                                // ),
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
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
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
                                const SizedBox(height: 16.0),
                                BlocBuilder<RegisterCubit, RegisterState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          registerCubit
                                              .registerWithEmailAndPassword(
                                            email: email!,
                                            password: password!,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          fixedSize: Size(screenSize.width, 50),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      child: state is RegisterLoding
                                          ? const CircularProgressIndicator()
                                          : Text(AppString.createAccount,
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
                            const SizedBox(height: 10.0),
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
                            const SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                'CONNECT WITH',
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
                            Gap(30),
                            InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      size: 13,
                                      color: AppColors.appOriginalWhite,
                                    ),
                                    Text(
                                      'Back to login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontFamily: 'Poppins',
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(30),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}
