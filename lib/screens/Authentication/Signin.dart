import 'dart:ui';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/screens/Authentication/SigninForm.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  static const String routeName = "/sign_in";

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Se connecter"),
        centerTitle: true,
        backgroundColor: main_bg_color,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Text(
                "Bienvenue",
                style: TextStyle(
                  color: main_bg_color,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0,),
              Text(
                "Connectez vous avec votre email et mot de passe.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SignForm(),
            ],
          ),
        ),
      )),
    );
  }
}
