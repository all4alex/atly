import 'dart:io';

import 'package:atly/src/app/atly_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

late FirebaseAuth firebaseAuth;
BuildContext? selectedTabScreenContext;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Platform.isAndroid
      ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ))
      : null;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebaseAuth = FirebaseAuth.instance;
  // firebaseAuth.useAuthEmulator('localhost', 1122);
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  runApp(
    AtlyApp(),
  );
}
