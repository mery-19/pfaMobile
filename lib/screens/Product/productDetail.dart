import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/components/footer.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Product.dart';
import 'package:pfaMobile/models/Promotion.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:pfaMobile/screens/Product/BestSell.dart';
import 'package:pfaMobile/screens/Product/arguments.dart';
import 'package:pfaMobile/services/EnviesService.dart';
import 'package:pfaMobile/services/PanierService.dart';
import 'package:pfaMobile/services/ProductService.dart';
import 'package:pfaMobile/session.dart';
import 'package:pfaMobile/theme.dart';

class ProductDetail extends StatefulWidget {
  static const String routeName = "/ProductDetail";
  final Product product;
  ProductDetail(this.product);

  @override
  _ProductDetailState createState() => _ProductDetailState(product);
}

class _ProductDetailState extends State<ProductDetail> {
  final Product product;
  _ProductDetailState(this.product);
  List<int> qtyList = new List<int>();
  int qty;
  bool isAvailable = true;
  var prix = 0.0;
  var economie = 0.0;
  var prix_vente = 0.0;
  bool promotionAvailable = false;
  Promotion promotion;

  @override
  void initState() {
    super.initState();

    setState(() {
      prix = product.prix_vente + product.prix_vente * product.tva / 100;
      prix_vente = prix;
      if (product.qty <= 0) {
        isAvailable = false;
      } else if (product.qty < 5) {
        for (int i = 1; i <= product.qty; i++) {
          qtyList.add(i);
        }
      } else {
        for (int i = 1; i < 5; i++) {
          qtyList.add(i);
        }
      }
    });
    if (connectedUser != null) {
      ProductService.getProductQty(product.id).then((value) {
        if (value != 0) {
          setState(() {
            qty = value;
          });
        }
      });
    }

    if (product.id_promotion != null) {
      promotion = HomePage.promotions
          .where((element) => element.id == product.id_promotion)
          .first;
      print(promotion.libele);
      if (DateTime.parse(promotion.date_expire).isAfter(DateTime.now())) {
        promotionAvailable = true;
        setState(() {
          economie = prix * promotion.taux_promotion / 100;
          prix = prix - economie;
        });
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: buildAppBar(args, context),
      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Stack(alignment: Alignment.topLeft, children: [
            Image.network(server + "Uploads/Produit_image/" + product.image,
                height: 200.0, width: MediaQuery.of(context).size.width),
            (product.qty <= 0)
                ? Image.asset("assets/images/Epuises.png",
                    height: 200.0, width: MediaQuery.of(context).size.width)
                : Text(""),
            (promotionAvailable)
                ? Container(
                    height: 30.0,
                    width: 50.0,
                    color: Colors.black54,
                    child: Center(
                        child: Text(
                      "-" + promotion.taux_promotion.toStringAsFixed(0) + "%",
                      style: TextStyle(
                          fontFamily: 'Inconsolata',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  )
                : Text("")
          ]),
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(product.name, style: name_style()),
          ),
          Divider(),
          productPrices(),
          SizedBox(height: 20.0),
          Divider(
            height: 20,
            thickness: 3,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("DESCRIPTION",
                style: TextStyle(
                    fontFamily: 'Inconsolata',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF575E67))),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(product.description, style: normal_text()),
          ),
          SizedBox(height: 40.0),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("MEILLEURS VENTES",
                style: TextStyle(
                    fontFamily: 'Inconsolata',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF575E67))),
          ),
          new BestSell(),
          SizedBox(height: 40.0),
          Footer()
          
        ],
      ),
    );
  }

  Column productPrices() {
    return Column(
      children: [
        SizedBox(height: 20.0),
        (economie != 0)
            ? Row(
                children: [
                  SizedBox(width: 50),
                  Text("Prix: ", style: normal_text()),
                  Text(prix_vente.toStringAsFixed(2) + "DH",
                      style: prix_style()),
                ],
              )
            : Text(""),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 50),
            Text("Prix de transaction: ", style: normal_text()),
            Text(prix.toStringAsFixed(2) + "DH", style: prix_transaction()),
            SizedBox(width: 10),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 50),
            Text(" Toutes taxes comprises"),
          ],
        ),
        SizedBox(height: 10.0),
        (economie != 0)
            ? Row(
                children: [
                  SizedBox(width: 50),
                  Text("Econimie: ", style: normal_text()),
                  Text(economie.toStringAsFixed(2) + "DH",
                      style: prix_economie()),
                ],
              )
            : Text(""),
        SizedBox(height: 20.0),
        Center(
          child: (isAvailable)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Qunatité"),

                    // focusColor: Colors.white,
                    value: qty,
                    // iconEnabledColor: Colors.black,
                    hint: Text(
                      (qty == null) ? "-- Quantité --" : qty.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    items: qtyList.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),

                    onChanged: (int value) {
                      if (connectedUser != null) {
                        setState(() {
                          qty = value;
                          PanierService.addProductToPanier(product.id, qty)
                              .then((value) {
                            if (value) {
                              toastMessage(
                                  "La quantité mise à jours avec succées.",
                                  Colors.green);
                            } else {
                              toastMessage("Erreur de serveur.", Colors.red);
                            }
                          });
                        });
                      } else {
                        toastMessage(
                            "Accéder a votre compte pour ajouter le produit au votre panier",
                            Colors.red);
                        qty = value;
                      }
                    },
                  ),
                )
              : Text(""),
        ),
      ],
    );
  }

  AppBar buildAppBar(ScreenArguments args, BuildContext context) {
    return AppBar(
      elevation: 0.1,
      backgroundColor: main_bg_color,
      title: Text(
        'MF Store',
        style: TextStyle(
          fontSize: headline6_size,
          fontFamily: 'Inconsolata',
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
        onPressed: () {
          if (args.page == 0) {
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     HomePage.routeName, (Route<dynamic> route) => false);
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: <Widget>[
        IconButton(
            icon:Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              if (connectedUser == null) {
                toastMessage("Connecter vous!", Colors.red);
              } else {
                EnviesService.add(product.id).then((value) {
                  print("enter");
                  toastMessage(
                      "Le produits a été ajouter avec succé.", Colors.green);
                });
              }
            }),
      ],
    );
  }
}
