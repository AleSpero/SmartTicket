import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_ticket/addproduct.dart';
import 'package:smart_ticket/home.dart';
import 'package:smart_ticket/scan.dart';

void main() => runApp(new SmartTicketApp());

class SmartTicketApp extends StatelessWidget {
  // This widget is the root of your application.

  static var colorPrimary = Colors.orange[700];
  static var colorPrimaryDark = Colors.orange[800];
  static var colorAccent = Colors.orange[900];
  static var greyBkg = Colors.grey[50];

  static var defaultCardElevation = 4.0;

  static var appTitle = "Smart Ticket";

  static const String ROUTE_HOME = "/";
  static const String ROUTE_SCAN = "/scan";
  static const String ROUTE_ADD_PRODUCT = "/add";
  static const String ST_CHANNEL = "smartTicket";
  static const String OCR_METHOD = "startOcr";

  static var primarySwatch = MaterialColor(0xFFF57C00, // colorPrimary.value,
      {
        50: colorPrimary,
        100: colorPrimary,
        200: colorPrimary,
        300: colorPrimary,
        400: colorPrimary,
        500: colorPrimary,
        600: colorPrimaryDark,
        700: colorAccent,
        800: colorAccent,
        900: colorAccent
      });

  final ThemeData androidThemeData = ThemeData(
      primarySwatch: primarySwatch,
      iconTheme: IconThemeData(color: Colors.white),
      primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)));

  static final isAndroid = defaultTargetPlatform == TargetPlatform.android;
  static const plaformChannel = const MethodChannel(ST_CHANNEL);

  static final TextStyle headerText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: Colors.black54
  );

  static final TextStyle mainCardHeaderText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: appTitle,
      theme: //TODO theme for ios
      androidThemeData,
      initialRoute: ROUTE_HOME,
      routes: {
        //che è sto context tra parentesi?
        ROUTE_HOME: (context) => HomeScreen(title: appTitle),
        ROUTE_SCAN: (context) => ScanScreen(null, title: appTitle),
        ROUTE_ADD_PRODUCT: (context) => AddProductScreen(null, title: appTitle)
      },
    );
  }
}