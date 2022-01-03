
import 'dart:io';

import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light().copyWith(primary: Colors.purple, secondary: Colors.white).copyWith(secondary: Colors.white)),
      themeMode: _themeMode,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.purple, secondary: Colors.white).copyWith(secondary: Colors.white)
      ),
    );
  }

  changeTheme(ThemeMode themeMode){
    setState(() {
      _themeMode = themeMode;
    });
  }
}

