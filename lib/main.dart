import 'package:comment_lines_remover/commons/colors.dart';
import 'package:comment_lines_remover/commons/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:comment_lines_remover/views/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'commons/constants.dart';

Future<void> main() async {
  if(!kIsWeb){
    await Future.delayed(const Duration(milliseconds: 1500));
    FlutterNativeSplash.remove();
  }
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Constants.font,
        colorScheme: ColorScheme.fromSeed(
          seedColor: MyColors.primary,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeUI(),
    );
  }
}