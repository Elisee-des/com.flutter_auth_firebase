import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/screens/home_screen.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  // we have also add the circular profressIndicator during waiting time
  bool isLoadin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("images/otpimage.jpg"),
            const Text(
              "OTP Verification",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Nous devons enregistrer votre numéro de téléphone en utilisant une vérification par code OTP à usage unique.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "+22656884514",
                  labelText: "Entrez votre telephone",
                ),
              ),
            ),
            // const SizedBox(height: 10),
            isLoadin
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      setState(() {
                        isLoadin = true;
                      });
                      try {
                        final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text,
                        );
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        isLoadin = false;
                      });
                    },
                    child: const Text(
                      "Envoyez le code",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ))
          ],
        ),
      )),
    );
  }
}
