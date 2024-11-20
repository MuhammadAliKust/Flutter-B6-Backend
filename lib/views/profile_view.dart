import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_backend/models/user.dart';
import 'package:flutter_b6_backend/services/user.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: StreamProvider.value(
          value: UserServices()
              .getUserByID(FirebaseAuth.instance.currentUser!.uid.toString()),
          initialData: UserModel(),
          builder: (context, child) {
            UserModel model = context.watch<UserModel>();
            return model.docId == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(model.name.toString()),
                      Text(
                        "PHone",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(model.phone.toString()),
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(model.email.toString())
                    ],
                  );
          }),
    );
  }
}
