import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall_app/components/button.dart';
import 'package:the_wall_app/components/loader.dart';
import 'package:the_wall_app/components/text_field.dart';

class Register extends StatefulWidget {
  final Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final emailText = TextEditingController();
    final passText = TextEditingController();
    final cPassText = TextEditingController();
    void displayMessage(String displayMessage) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(displayMessage),
              ));
    }

    void signUp() async {
      FancyLoader.show(context, "Registering...");
      if (passText.text != cPassText.text) {
        Navigator.pop(context);
        displayMessage("Passwords do not match");
        return;
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailText.text, password: passText.text);
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessage(e.code);
      }
    }

    return Scaffold(
      backgroundColor: Colors.indigo[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Icon to be inserted",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
                const SizedBox(height: 20),
                const Text("WELCOME BACK :)",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
                const SizedBox(height: 40),
                MyTextField(
                    controller: emailText,
                    hintText: "Email",
                    obscureText: false),
                const SizedBox(height: 24),
                MyTextField(
                    controller: passText,
                    hintText: "Password",
                    obscureText: true),
                const SizedBox(height: 16),
                MyTextField(
                    controller: cPassText,
                    hintText: "Confirm Password",
                    obscureText: true),
                const SizedBox(height: 16),
                MyBtn(text: "Register", onTap: signUp),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      Text(
                        " Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.indigo[800],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
