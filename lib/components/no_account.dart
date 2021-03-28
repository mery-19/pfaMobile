import 'package:pfaMobile/constants.dart';
import 'package:flutter/material.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
                  child: Container(
            child: Text(
              "Vouz n'avez pas un compte? ",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Flexible(
          flex: 1,
                  child: Container(
            child: GestureDetector(
              onTap: () =>{},
              child: Text(
                "Créer un compte",
                style: TextStyle(fontSize: 20, color: main_bg_color, fontWeight: FontWeight.bold),

              ),
            ),
          ),
        ),
      ],
    );
  }
}
