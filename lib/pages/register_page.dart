import 'package:authorization/components/my_button.dart';
import 'package:authorization/components/my_textfield.dart';
import 'package:authorization/components/square_tile.dart';
import 'package:authorization/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final double padPercent = 0.06;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        wrongData("Passwords don't match");
      }

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
                  'Let\'s create an account fot you',
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
                // confirm password
                MyTextField(
                  padPercent: padPercent,
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * (padPercent / 4),
                ),
                // sign in
                MyButton(
                  padPercent: padPercent,
                  onTap: signUserUp,
                  text: "Sign Up",
                ),
                // SizedBox(
                //   height: MediaQuery.sizeOf(context).height * (padPercent),
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
                  height: MediaQuery.sizeOf(context).height * (padPercent / 2),
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
                      MediaQuery.sizeOf(context).height * (padPercent / 1.2),
                ),
                // login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.sizeOf(context).height * (padPercent / 10),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login",
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
