import 'package:flutter/material.dart';
import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/LignePanier.dart';
import 'package:pfaMobile/screens/Envies/EnviesScreen.dart';
import 'package:pfaMobile/services/EnviesService.dart';
import 'package:pfaMobile/theme.dart';

class EnvieItem extends StatelessWidget {
  LignePanier lignePanier;
  BuildContext context1;
  bool isAvailable = false;
  List<int> qtyList = new List<int>();
  int qty;
  var totalPrixTxt = ValueNotifier<String>("0.0");

  EnvieItem({this.lignePanier, this.context1});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      child: Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        server + "Uploads/Produit_image/" + lignePanier.image,
                        height: MediaQuery.of(context).size.width / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          lignePanier.name,
                          style: normal_text(),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(lignePanier.prix.toStringAsFixed(2) + " DHs",
                            style: TextStyle(
                              fontFamily: 'Inconsolata',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: main_bg_color,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        IconButton(
                            icon: Icon(Icons.delete),
                            iconSize: 30.0,
                            color: Colors.red,
                            onPressed: () {
                              EnviesService.delete(lignePanier.id)
                                  .then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EnviesScreen()),
                                    (route) => false);
                              });
                            })
                      ],
                    )),
              ],
            ),
          )),
    ));
  }
}

TextStyle buildTextStyle() {
  return TextStyle(
    fontSize: 20,
  );
}
