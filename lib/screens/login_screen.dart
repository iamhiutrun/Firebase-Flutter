import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/entity/user.dart';
import 'package:login_firebase/utils.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  var passwordWarning = false;
  var emailWarning = false;

  void isValid() {
    if (!Utils.isEmailValid(emailController)) {
      emailWarning = true;
    } else {
      emailWarning = false;
    }
    if (!Utils.isPasswordValid(passwordController)) {
      passwordWarning = true;
    } else {
      passwordWarning = false;
    }
    if (Utils.isPasswordValid(passwordController) &&
        Utils.isEmailValid(emailController)) {
      ref
          .child('user')
          .push()
          .set(User(emailController.text, passwordController.text).toJson());
    }
    notifyListeners();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Continue with email',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: data.emailController,
                  decoration: InputDecoration(
                    errorText: data.emailWarning ? "email không hợp lệ" : null,
                    labelText: 'email',
                    prefixIcon: const Icon(Icons.mail),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: data.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: data.passwordWarning
                        ? "Mật khẩu ít nhất 8 kí tự"
                        : null,
                    labelText: 'mật khẩu',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      data.isValid();
                    },
                    child: const Text("Đăng nhập"),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: const Text(
                    "Quên mật khẩu",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Bạn chưa có tài khoản?'),
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
