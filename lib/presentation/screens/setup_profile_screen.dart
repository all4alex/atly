import 'package:atly/app/app_colors.dart';
import 'package:atly/app/app_text.dart';
import 'package:atly/data/models/user_profile_model.dart';
import 'package:atly/logic/cubit/cubit/profile_cubit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'home_screen/nav_screen.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/setupProfile';
  static const String screenName = 'SetupProfileScreen';
  static ModalRoute<dynamic> route() => MaterialPageRoute<dynamic>(
      builder: (context) => SetupProfileScreen(),
      settings: RouteSettings(name: routeName));

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  UserProfileModel userProfileModel = UserProfileModel();
  final _formKey = GlobalKey<FormState>();
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
  }

  void showErrorMessage(BuildContext context) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Opps!',
        message: 'Something went wrong.',

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
    final Size size = MediaQuery.of(context).size;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          Navigator.of(context, rootNavigator: true)
              .pushReplacement(NavScreen.route(menuScreenContext: context));
        } else if (state is ProfileFailed) {
          showErrorMessage(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.appWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(50),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/icons/atly_icon_logo.png',
                      height: size.height * .12,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text(
                    'Acount Set Up',
                    style: AppText.subtitle1.copyWith(
                        color: AppColors.appBlue, fontWeight: FontWeight.bold),
                  ),
                  Gap(50),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'PROFILE',
                      style:
                          AppText.subtitle2.copyWith(color: AppColors.appBlue),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "First Name",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: AppColors.appGrey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First Name can't be empty";
                      }
                      return null;
                    },
                    onSaved: (newValue) =>
                        userProfileModel.firstName = newValue,
                  ),
                  Gap(10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: AppColors.appGrey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last Name can't be empty";
                      }
                      return null;
                    },
                    onSaved: (newValue) => userProfileModel.lastName = newValue,
                  ),
                  Gap(10),
                  TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Contact Number",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: AppColors.appGrey),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Contact Number can't be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) =>
                          userProfileModel.contactNumber = newValue),
                  Gap(10),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Birthday",
                      filled: true,
                      suffix: Text(
                        'OPTIONAL',
                        style: AppText.caption.copyWith(
                          color: AppColors.appBlack,
                        ),
                      ),
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: AppColors.appGrey),
                      ),
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Birthday can't be empty";
                    //   }
                    //   return null;
                    // },
                    onSaved: (newValue) => userProfileModel.bday = newValue,
                  ),
                  Gap(10),
                  TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Country",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: AppColors.appGrey),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Country can't be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) =>
                          userProfileModel.country = newValue),
                  Gap(10),
                  TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "City",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: AppColors.appGrey),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "City can't be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) => userProfileModel.city = newValue),
                  Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      profileCubit.saveUserProfile(
                          userProfileModel: userProfileModel);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appBlue,
                        fixedSize: Size(size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: Text('Create Account',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontFamily: 'Poppins',
                                  color: AppColors.appOriginalWhite,
                                  fontWeight: FontWeight.bold,
                                )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
