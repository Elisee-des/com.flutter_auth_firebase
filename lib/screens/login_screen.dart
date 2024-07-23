import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_auth_firebase/Services/authentication.dart';
import 'package:flutter_auth_firebase/Services/google_auth.dart';
import 'package:flutter_auth_firebase/screens/home_screen.dart';
import 'package:flutter_auth_firebase/screens/phone_login.dart';
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
        child: SingleChildScrollView( // Envelopper la `Column` dans un `SingleChildScrollView`
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
                    icon: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    ),
                TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "Entrez votre mot de passe",
                    isPass: true,
                    icon: Icons.lock,
                    textInputType: TextInputType.visiblePassword,
                    ),
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
                Row(
                  children: [
                    Expanded(
                      child: Container(height: 1, color: Colors.black26),
                    ),
                    const Text("  ou  "),
                    Expanded(
                      child: Container(height: 1, color: Colors.black26),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                    onPressed: () async {
                      await FirebaseServices().signInWithGoogle();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Image.asset("images/logo-google.png", height: 35,),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Continuez avec Google",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const PhoneAuthentication(),
                SizedBox(height: height / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vous n'avez pas de compte ?",
                      style: TextStyle(fontSize: 16),
                    ),
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
        ),
      ),
    );
  }
}
