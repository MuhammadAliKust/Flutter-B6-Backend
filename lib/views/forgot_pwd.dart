import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/services/auth.dart';
import 'package:flutter_b6_backend/views/register.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await AuthServices()
                      .forgotPassword(
                    emailController.text,
                  )
                      .then((val) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content: Text("An email with password reset link has been sent to your mail box."),
                          );
                        });
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Text("Login")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
              },
              child: Text("Go to Register"))
        ],
      ),
    );
  }
}
