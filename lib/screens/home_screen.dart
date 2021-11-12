import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/providers/firebase_authentication_provider.dart';
import 'package:login_firebase/screens/register_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription<User?> loginStateSubscription;

  @override
  void initState() {
    loginStateSubscription =
        Provider.of<FirebaseAuthentication>(context, listen: false)
            .currentUser
            .listen((user) {
      if (user == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const RegisterScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: Provider.of<FirebaseAuthentication>(context).currentUser,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data!.photoURL!),
                  radius: 60.0,
                ),
                ElevatedButton(
                  onPressed: () => Provider.of<FirebaseAuthentication>(context,listen: false).logOut(),
                  child: const Text('Đăng xuất'),
                ),
              ],
            ),
          );
        }
      },
    ));
  }
}
