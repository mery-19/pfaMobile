import 'package:flutter/material.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/LignePanier.dart';
import 'package:pfaMobile/screens/Commandes/ProductsInCommande.dart';
import 'package:pfaMobile/screens/Panier/PanierItem.dart';
import 'package:pfaMobile/services/CommandeService.dart';

class CommandeItem extends StatefulWidget {
  BuildContext context;
  int id;
  double prix_total;
  String date_ajout;
  int id_status;
  String date_update;

  CommandeItem({
    this.context,
    this.id,
    this.prix_total,
    this.date_ajout,
    this.id_status,
    this.date_update,
  });
  @override
  _CommandeItemState createState() => _CommandeItemState(
        this.context,
        this.id,
        this.prix_total,
        this.date_ajout,
        this.id_status,
        this.date_update,
      );
}

class _CommandeItemState extends State<CommandeItem> {
  final BuildContext context;
  final int id;
  final double prix_total;
  final String date_ajout;
  final int id_status;
  final String date_update;

  List<LignePanier> lignes = new List<LignePanier>();

  _CommandeItemState(
    this.context,
    this.id,
    this.prix_total,
    this.date_ajout,
    this.id_status,
    this.date_update,
  );

  @override
  void initState() {
    super.initState();
    CommandeService.fetchProductsCommandes(id).then((value) {
      setState(() {
        lignes = value;
        print(lignes);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SizedBox(height: height_box),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        (id_status == 1)
                            ? Icon(
                                Icons.departure_board_outlined,
                                color: Colors.blue,
                                size: 60.0,
                              )
                            : Icon(
                                Icons.domain_verification_outlined,
                                color: Colors.green,
                                size: 60.0,
                              ),
                        SizedBox(width: height_box),
                        Text(
                          "Id: " + id.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: main_bg_color_2,
                    onPressed: () {
                      buildShowDialog(context, id);
                    },
                    child: Text("Détails",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Text(
                      "Ajouté le: "+date_ajout.split("T")[0],
                      style: buildTextStyle(),
                    ),
                   
                    SizedBox(height: 10,),
                     (id_status == 2)?
                    Text(
                      "Confirmer le: "+date_update.split("T")[0],
                      style: buildTextStyle(),
                    ):Text(""),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
      fontSize: 20,
    );
  }

  Future buildShowDialog(BuildContext context, int id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Les produits commandées:"),
          content: SingleChildScrollView(
                      child: Column(
              children: []..addAll(produitsCommandee(context)),
            ),
          ),
          actions: [
            FlatButton(
              shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: main_bg_color_2,
                child: Text("Fermé",style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          )),
  
                onPressed: () {
                  print("no");
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  List<Widget> produitsCommandee(BuildContext context) {
    return lignes
        .map((e) => new ProductsInCommande(
              lignePanier: e,
              context1: context,
            ))
        .toList();
  }
}
