import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/services/auth.dart';
import 'package:flutter_b6_backend/views/forgot_pwd.dart';
import 'package:flutter_b6_backend/views/get_all_task.dart';
import 'package:flutter_b6_backend/views/register.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: pwdController,
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await AuthServices()
                      .loginUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((val) {
                    if (val != null) {
                      if (val.emailVerified == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetAllTaskView()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content: Text("Kindly verify your email"),
                              );
                            });
                      }
                    }
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
              child: Text("Go to Register")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordView()));
              },
              child: Text("Go to Forgot Password"))
        ],
      ),
    );
  }
}
