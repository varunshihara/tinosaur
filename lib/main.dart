// import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

// import 'backdrop.dart';
import 'login.dart';
import 'tinohome.dart';
import 'colors.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'category_menu_page.dart';
import 'model/product.dart';
import 'supplemental/cut_corners_border.dart';

void main() => runApp(TinoApp());

// TODO: Build a Shrine Theme (103)
final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: tcDarkBlue,
    primaryColor: tcLightGreen,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: tcLightGreen,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: tcBackgroundWhite,
    cardColor: tcBackgroundWhite,
    textSelectionColor: tcLightGreen,
    errorColor: tcErrorRed,
    // TODO: Add the text themes (103)
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    // TODO: Add the icon themes (103)
    primaryIconTheme: base.iconTheme.copyWith(color: tcDarkBlue),
    // brightness: Brightness.light,
    // TODO: Decorate the inputs (103)
    // inputDecorationTheme: InputDecorationTheme(
    //   border: CutCornersBorder(),
    // ),
  );
}

// TODO: Build a Shrine Text Theme (103)
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: tcDarkBlue,
        bodyColor: tcDarkBlue,
      );
}

class TinoApp extends StatefulWidget {
  @override
  _TinoAppState createState() => _TinoAppState();
}

class _TinoAppState extends State<TinoApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget _home = LoginPage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _home = _handleWindowDisplay();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return MaterialApp(
      title: 'Tinosaur',
      home: _home,
      theme: _kShrineTheme,
    );
  }

  Widget _handleWindowDisplay() {
    return StreamBuilder(
      stream: _auth.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoginPage();
        } else {
          if (snapshot.hasData) {
            return MainScreen();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
