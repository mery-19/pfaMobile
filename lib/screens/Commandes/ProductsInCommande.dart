import 'package:flutter/material.dart';
import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/LignePanier.dart';
import 'package:pfaMobile/theme.dart';

class ProductsInCommande extends StatelessWidget {
  LignePanier lignePanier;
  BuildContext context1;
  bool isAvailable = false;
  List<int> qtyList = new List<int>();
  int qty;
  var totalPrixTxt = ValueNotifier<String>("0.0");

  ProductsInCommande({this.lignePanier, this.context1});
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
                        Text("Quantité: " + lignePanier.quantite.toString(),
                            style: TextStyle(
                              fontFamily: 'Inconsolata',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: main_bg_color_2,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                            (lignePanier.prix * lignePanier.quantite)
                                    .toStringAsFixed(2) +
                                " DHs",
                            style: TextStyle(
                              fontFamily: 'Inconsolata',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: main_bg_color,
                            ))
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

Future buildShowDialog(BuildContext context, String id) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Book store!"),
        content: Text("Are you sure you want to delete this book store?"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                print("no");
                Navigator.pop(context);
              })
        ],
      );
    },
  );
}
