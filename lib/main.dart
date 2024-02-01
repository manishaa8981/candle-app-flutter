import 'package:candel/screens/auth/%20resetPassword.dart';
import 'package:candel/screens/auth/login_screen.dart';
import 'package:candel/screens/auth/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
      runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      initialRoute: "/login",
      routes: {
    "/login":(BuildContext context) => LoginScreen(),
        "/register":(BuildContext context) => RegisterScreen(),
        "/resetPassword":(BuildContext context) => resetPassword()
    },
    );
  }
}


