import 'package:pfaMobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

AppBarTheme appBarTheme(){
  return AppBarTheme(
        color:main_bg_color,
          //elevation: 0, // elevation for shadow
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: headline6_color,
              //Color(0XFF8B8B8B), 
              fontSize: headline6_size,
          
              )
               )
        );
}

ThemeData themeData(){
  return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Inconsolata",
        appBarTheme: appBarTheme(),
        textTheme: TextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}


OutlineInputBorder inputBorderStyle() {
    return OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: main_bg_color),
              gapPadding: 10,
            );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
            borderSide: BorderSide(color: main_bg_color),
            borderRadius: BorderRadius.circular(28),
          );
  }

   InputDecoration inputDecoration(String labelText) {
      return InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: field_padding,
          border: inputBorderStyle(),
          focusedBorder: outlineInputBorder());
    }

  void toastMessage(String message, Color color){
   Fluttertoast.showToast(
       msg: message,
       toastLength: Toast.LENGTH_LONG,
       timeInSecForIosWeb: 1,
       backgroundColor: color,
       gravity: ToastGravity.CENTER,
       fontSize: 16.0
   );
}

  TextStyle prix_style() {
    return TextStyle(
                    fontFamily: 'Inconsolata',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color:Color(0xFF545D68),
                    decoration:TextDecoration.lineThrough);
  }

    TextStyle prix_transaction() {
    return TextStyle(
                    fontFamily: 'Inconsolata',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: main_bg_color,);
  } 
  TextStyle prix_economie() {
    return TextStyle(
                    fontFamily: 'Inconsolata',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,);
  }

    TextStyle name_style() {
    return TextStyle(
              fontFamily: 'Inconsolata',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF575E67));
  }

    TextStyle normal_text() {
    return TextStyle(
                fontFamily: 'Inconsolata',
                fontSize: 20.0,
                color: Color(0xFF575E67));
  }

