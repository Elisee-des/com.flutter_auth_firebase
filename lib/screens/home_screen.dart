import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/Services/authentication.dart';
import 'package:flutter_auth_firebase/screens/login_screen.dart';
import 'package:flutter_auth_firebase/widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Felicitaion, vous êtes connecter avec succès !!!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold
              ),
            ),
            ButtonWidget(onTab: () async {
              await AuthServices().signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
            }, text: "Se deconnecter")
          ],
        ),
    )
    )
    ;
  }
}