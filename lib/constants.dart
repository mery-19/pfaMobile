import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final double height_box = 20.0;
final RegExp regExpEmail = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final icon_padding = EdgeInsets.fromLTRB(0, 0, 30, 0);
final field_padding = EdgeInsets.fromLTRB(30, 0, 0, 0);

final String key =
    "Vf8B/tTrHUcW54DQ34iOjA==:n03sZtr/O3pntq7Y2sZqDMaPFSdrQoNjpSahcI3kYzI=";

Color main_bg_color  = new Color.fromRGBO(255, 124, 91,1);
Color main_bg_color_2 = new Color.fromRGBO(45, 62, 80, 1);


final headline6_color = Colors.white;
final headline6_size = 20.0;

Map<String, dynamic> cart;

String image64 = null;

circularProgress() {
  return Center(
    child: const CircularProgressIndicator(),
  );
}
