import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfaMobile/components/default_button.dart';
import 'package:pfaMobile/components/no_account.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:pfaMobile/services/AuthService.dart';
import 'package:pfaMobile/theme.dart';
import 'package:http/http.dart' as http;
import 'package:pfaMobile/URLs.dart';


class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}
class _SignFormState extends State<SignForm> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    void signIn() async{
      // http.Response res = await http.post(authApi, body: {
      //     "email": _email.text,
      //     "password": _password.text,
      //   }, headers: {
      //     "Accept": "application/json"
      //   });
        AuthService.login(_email.text, _password.text).then((value) => print("here"));

        // if(res.body.isEmpty){
        //   toastMessage("Email ou mot de passe invalide.", main_bg_color);
        // } else{
        // connected_user = jsonDecode(res.body);
        // Navigator.pop(context);
        // Navigator.pushNamed(context, HomePage.routeName);
        // }
    }

    return Form(
      key: _keyForm,
      child: Column(
        children: [
          SizedBox(height: height_box),
          emailTextFormField(),
          SizedBox(height: height_box),
          passwordTextFormField(),
          SizedBox(height: height_box),
          SizedBox(height: height_box),
          DefaultButton(
              text: "Connect",
              press: () {
                if (_keyForm.currentState.validate()) {

                  signIn();
                } 
              }),
          SizedBox(height: height_box),
          NoAccount()
        ],
      ),
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
        controller: _password,
        obscureText: true,
        validator: (value) {
          RegExp regExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$");
          // ^: first line
          // (?=.*[a-z]) : Should have at least one lower case
          // (?=.*[A-Z]) : Should have at least one upper case
          // (?=.*\d) : Should have at least one number
          // (?=.*[#$^+=!*()@%&] ) : Should have at least one special character
          // .{8,} : Minimum 8 characters
          // $ : end line
          bool matches = regExp.hasMatch(value);
          print("--------------RegExp-------------------");
          print(matches);
          print("--------------RegExp-------------------");
          if (! matches) {
            return 'Le mot de passe est invalide. ';
          }
          return null;
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(
                      color:Colors.black
                    ),
            labelText: "Mot de passe",
            hintText: "Entrer le mot de passe.",
            suffixIcon: Padding(
              padding: icon_padding,
              child: Icon(Icons.lock,
              color: main_bg_color),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: field_padding,
            border: inputBorderStyle(),
            focusedBorder: outlineInputBorder()));
  }

  TextFormField emailTextFormField() {
    return TextFormField(
        controller: _email,
        validator: (value) {
          if (value.isEmpty) {
            return 'Entrer votre email.';
          } else if (!value.contains("@")) {
            return 'Email est invalide';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelStyle: TextStyle(
                      color:Colors.black
                    ),
            labelText: "Email",
            hintText: "Email",
            suffixIcon: Padding(
              padding: icon_padding,
              child: Icon(Icons.email,
              color: main_bg_color),
              
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: field_padding,
            border: inputBorderStyle(),
            focusedBorder: outlineInputBorder()
            
            ));
  }

}
