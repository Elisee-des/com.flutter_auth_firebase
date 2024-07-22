import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/screens/login_screen.dart';

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
                    icon: Icons.lock),
                
                ButtonWidget(onTab: () {}, text: "S'inscrire"),
                SizedBox(height: height / 15),
                Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Text("Vous avez déja un compte?", style: TextStyle(fontSize: 16),),
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