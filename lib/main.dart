import 'package:data_collection/providers/connectivity_provider.dart';
import 'package:data_collection/views/dashboard.dart';
import 'package:data_collection/views/home.dart';
import 'package:data_collection/views/mysplash.dart';
import 'package:data_collection/views/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: MySplash(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Montserrat',
            primarySwatch: Colors.blue,
          ),
          home: MySplash(),
          routes: {
            //'/': (context) => SplashScreen(),

            '/dashboard': (context) => Dashboard(),
          }),
    );
  }
}
