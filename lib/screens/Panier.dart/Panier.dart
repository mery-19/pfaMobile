import 'package:pfaMobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/models/LignePanier.dart';
import 'package:pfaMobile/screens/Panier.dart/PanierItem.dart';
import 'package:pfaMobile/services/PanierService.dart';

class Panier extends StatefulWidget {
  static const String routeName = "/panier";

  @override
  _PanierState createState() => _PanierState();

  
}

class _PanierState extends State<Panier> {
  List<LignePanier> lignePaniers = new List<LignePanier>();
   @override
  void initState() {
    super.initState();
    PanierService.fetchAll().then((value){
      setState(() {
        lignePaniers = value;
      });
      print(lignePaniers);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mo Panier"),
        centerTitle: true,
        backgroundColor: main_bg_color,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:   10, vertical: 10),
          child: Column(
            children: [

            ]..addAll(productsInPanier()),

          ),
        ),
      )),
    );
  }

   List<Widget> productsInPanier() {
    return lignePaniers
        .map((e) => new PanierItem(
            lignePanier: e
            ))
        .toList();
  }
}
