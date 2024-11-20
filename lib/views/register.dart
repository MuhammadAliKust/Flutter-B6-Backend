import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/models/user.dart';
import 'package:flutter_b6_backend/services/auth.dart';
import 'package:flutter_b6_backend/services/user.dart';
import 'package:flutter_b6_backend/views/login.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(label: Text("Name")),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(label: Text("Phone")),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(label: Text("Email")),
          ),
          TextField(
            controller: pwdController,
            decoration: InputDecoration(label: Text("Password")),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await AuthServices()
                      .registerUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((val) async {
                    if (val != null) {
                      await UserServices()
                          .createUser(UserModel(
                              docId: val.uid.toString(),
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text))
                          .then((val) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content: Text(
                                    "User has been registered successfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginView()));
                                      },
                                      child: Text("Go to Login"))
                                ],
                              );
                            });
                      });
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Text("Register"))
        ],
      ),
    );
  }
}
