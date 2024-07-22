import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_auth_firebase/Services/authentication.dart';
import 'package:flutter_auth_firebase/screens/home_screen.dart';
import 'package:flutter_auth_firebase/screens/signup_screen.dart';
import 'package:flutter_auth_firebase/widgets/button_widget.dart';
import 'package:flutter_auth_firebase/widgets/snack_bar.dart';
import 'package:flutter_auth_firebase/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthServices().loginUser(
        email: _emailController.text,
        password: _passwordController.text,
        );

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
                  child: Image.asset("images/login.jpg"),
                ),
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Entrez votre email",
                    icon: Icons.email),
                TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "Entrez votre mot de passe",
                    isPass: true,
                    icon: Icons.lock),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Mot de passe oublier ?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue),
                    ),
                  ),
                ),
                ButtonWidget(onTab: loginUser, text: "Connexion"),
                SizedBox(height: height / 15),
                Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Text("Vous n'avez pas de compte ?", style: TextStyle(fontSize: 16),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    " S'inscrire",
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
