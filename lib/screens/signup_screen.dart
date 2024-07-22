import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/Services/authentication.dart';
import 'package:flutter_auth_firebase/screens/home_screen.dart';
import 'package:flutter_auth_firebase/screens/login_screen.dart';
import 'package:flutter_auth_firebase/widgets/snack_bar.dart';

import '../widgets/button_widget.dart';
import '../widgets/text_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }


  void signUser() async {
    String res = await AuthServices().signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);

    if (res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 2.7,
                  width: double.infinity,
                  child: Image.asset("images/signup.jpeg"),
                ),
                TextFieldInput(
                    textEditingController: _nameController,
                    hintText: "Entrez votre nom complet",
                    icon: Icons.person),
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Entrez votre email",
                    icon: Icons.email),
                TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "Entrez votre mot de passe",
                    isPass: true,
                    icon: Icons.lock),
                isLoading
                    ? const CircularProgressIndicator()
                    : ButtonWidget(onTab: signUser, text: "S'inscrire"),
                SizedBox(height: height / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vous avez déja un compte?",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        " Se connecter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
