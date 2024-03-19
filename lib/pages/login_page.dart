import 'package:authorization/components/my_button.dart';
import 'package:authorization/components/my_textfield.dart';
import 'package:authorization/components/square_tile.dart';
import 'package:authorization/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double padPercent = 0.06;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongData(e.code);
    }
  }

  void wrongData(String data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Text(
              data,
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * padPercent,
                ),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * padPercent,
                ),
                // welcome
                Text(
                  'Welcome back you\'ve been missed',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * (padPercent / 2),
                ),
                // username
                MyTextField(
                  padPercent: padPercent,
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * (padPercent / 4),
                ),
                // password
                MyTextField(
                  padPercent: padPercent,
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * (padPercent / 4),
                ),
                // forogt passw
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.sizeOf(context).height * padPercent / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * (padPercent / 4),
                ),
                // sign in
                MyButton(
                  padPercent: padPercent,
                  onTap: signUserIn,
                  text: "Sign In",
                ),
                // SizedBox(
                //   height: MediaQuery.sizeOf(context).height * (padPercent / 4),
                // ),
                //or cont with
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.sizeOf(context).height * (padPercent / 2)),
                  child: Row(children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).height *
                              (padPercent / 4)),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * (padPercent),
                ),

                // apple google
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: 'lib/img/google.png',
                      padPercent: padPercent,
                      onTap: () => AuthService().signInWithGoogle(),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.sizeOf(context).height * (padPercent / 3),
                    ),
                    SquareTile(
                      imagePath: 'lib/img/apple.png',
                      padPercent: padPercent,
                      onTap: () => AuthService().signInWithGoogle(),
                    )
                  ],
                ),
                SizedBox(
                  height:
                      MediaQuery.sizeOf(context).height * (padPercent * 1.2),
                ),
                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.sizeOf(context).height * (padPercent / 10),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
