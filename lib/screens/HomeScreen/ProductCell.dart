import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/models/Promotion.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:pfaMobile/services/PromotionService.dart';

class ProductCell extends StatefulWidget {
  final Product product;
  ProductCell(this.product);

  @override
  _ProductCellState createState() => _ProductCellState(product);
}

class _ProductCellState extends State<ProductCell> {
  final Product product;
  _ProductCellState(this.product);
  var prix = 0.0;
  var economie = 0.0;
  var prix_vente = 0.0;
  List<Promotion> promotions;
  Promotion promotion;
  bool promotionAvailable = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      prix = product.prix_vente + product.prix_vente * product.tva / 100;
      prix_vente = prix;
    });
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
    return (product == null)
        ? circularProgress()
        : Card(
          
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child:Stack(
          
           alignment: Alignment.topLeft,
              children: [
                
                Image.network(server + "Uploads/Produit_image/" + product.image,
              height: 200.0, width:MediaQuery.of(context).size.width),
              (product.qty <=0)?Image.asset("assets/images/Epuises.png",
              height: 200.0, width:MediaQuery.of(context).size.width):Text(""),
              (promotionAvailable)?Container(
                  height: 30.0,
                  width: 50.0,
                  color: Colors.black54,
                  child: Center(child: Text("-"+promotion.taux_promotion.toStringAsFixed(0)+"%",style:
                  TextStyle(
              fontFamily: 'Inconsolata',
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )

                  ,)),
                ):Text(""),
                            ],
        ),
                    )),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            product.name,
                            maxLines: 4,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 10.0, 2.0, 5.0),
                                child: Text(
                                  prix.toStringAsFixed(2) + "DH",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              (economie != 0)
                                  ? Text(
                                      prix_vente.toStringAsFixed(2) + "DH",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : Text(""),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
