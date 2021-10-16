import 'package:data_collection/local_db/db_helper.dart';
import 'package:data_collection/providers/connectivity_provider.dart';
import 'package:data_collection/views/dashboard.dart';
import 'package:data_collection/views/demandnotice.dart';
import 'package:data_collection/views/login.dart';
import 'package:data_collection/views/mysplash.dart';
import 'package:data_collection/views/propertydetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteDatabaseHelper.instance.db;
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
            '/login': (context) => LoginPage(),
          }),
    );
  }
}
