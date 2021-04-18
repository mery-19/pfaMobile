import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/constants.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: main_bg_color_2,
        height: 100.0,
        child: Center(
            child: Text("© Copyright 2021 MFStore ENSA Fes",
                style: TextStyle(
                    fontFamily: 'Inconsolata',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))));
  }
}
