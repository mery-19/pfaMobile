import 'package:flutter/material.dart';
import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/models/LignePanier.dart';
import 'package:pfaMobile/screens/Panier/Panier.dart';
import 'package:pfaMobile/services/EnviesService.dart';
import 'package:pfaMobile/services/PanierService.dart';
import 'package:pfaMobile/theme.dart';

class PanierItem extends StatefulWidget {
  final BuildContext context;
  final LignePanier lignePanier;

  PanierItem({this.lignePanier, this.context});
  @override
  _PanierItemState createState() => _PanierItemState(lignePanier, context);
}

class _PanierItemState extends State<PanierItem> {
  LignePanier lignePanier;
  BuildContext context;
  double prixTotal = 0.0;
  bool isAvailable = false;
  List<int> qtyList = new List<int>();
  int qty;
  var totalPrixTxt = ValueNotifier<String>("0.0");

  _PanierItemState(this.lignePanier, this.context);

  @override
  void initState() {
    super.initState();
    setState(() {
      prixTotal = lignePanier.prix * lignePanier.quantite;
      totalPrixTxt.value = prixTotal.toStringAsFixed(2);
      if (lignePanier.quantite_disponible <= 0) {
        isAvailable = false;
      } else if (lignePanier.quantite_disponible < 5) {
        for (int i = 1; i <= lignePanier.quantite_disponible; i++) {
          qtyList.add(i);
        }
      } else {
        for (int i = 1; i <= 5; i++) {
          qtyList.add(i);
        }
      }
    });
  }

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
                      Text(
                        lignePanier.name,
                        style: normal_text(),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                          server + "Uploads/Produit_image/" + lignePanier.image,
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 2),
                      SizedBox(height: 10),
                      ValueListenableBuilder(
                          valueListenable: totalPrixTxt,
                          builder: (context, value, widget) {
                            return Text(
                              totalPrixTxt.value + " DHs",
                              style: prix_transaction(),
                            );
                          })
                    ],
                  ),
                ),
                Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                            child: SizedBox(
                          height: 100.0,
                          child: DropdownButtonFormField(
                            value: lignePanier.quantite,
                            items:
                                qtyList.map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                var total = lignePanier.prix * value;
                                totalPrixTxt.value = total.toStringAsFixed(2);
                              });
                              print("enter");
                              PanierService.updateQuantite(
                                      lignePanier.id, value)
                                  .then((ligne) {
                                setState(() {
                                  lignePanier.prix =
                                      lignePanier.prix * ligne.quantite;
                                });
                              });
                            },
                          ),
                        )),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.red[200],
                                  ),
                                  onPressed: () {
                                     EnviesService.add(lignePanier.id).then((value) {
                                      toastMessage(
                                          "Le produit a été ajouter avec succé.", Colors.green);
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    //delete product from the list:
                                    PanierService.deleteProduct(lignePanier.id)
                                        .then((value) {
                                      if (value) {

                                        setState(() {
                                          Panier.lignePaniers.remove(lignePanier);
                                        });


                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Panier()),
                                            (route) => false);
                                      }
                                    });
                                  }),
                            ],
                          ),
                        )
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
