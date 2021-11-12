import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/providers/firebase_authentication_provider.dart';
import 'package:login_firebase/screens/forgot_password.dart';
import 'package:login_firebase/screens/login_screen.dart';
import 'package:login_firebase/screens/register_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (_) => const LoginScreen(),
          '/forgot': (_) => const ForgotScreen(),
          '/register': (_) => const RegisterScreen()
        },
      ),
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseAuthentication(),
        ),
      ],
    ),
  );
}
