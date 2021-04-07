import 'package:flutter/material.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Commande.dart';
import 'package:pfaMobile/screens/Commandes/CommandeItem.dart';
import 'package:pfaMobile/services/CommandeService.dart';

class CommandesScreen extends StatefulWidget {
  static const String routeName = "/books_store";

  @override
  _CommandesScreenState createState() => _CommandesScreenState();
}

class _CommandesScreenState extends State<CommandesScreen> {
  List<Commande> commandes = new List<Commande>();

  @override
  void initState() {
    super.initState();
    CommandeService.fetchAllCommandes().then((value){
      setState(() {
              commandes = value;

      });
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: main_bg_color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Mes commandes",
          style: TextStyle(
            fontSize: headline6_size,
            fontFamily: 'Inconsolata',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  flex: 2,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: main_bg_color,
                    onPressed: () {},
                    child: Text("Toutes mes commandes",style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          )),
                  )
                  ),
                                    SizedBox(width: 10),

                    Flexible(
                  flex: 1,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text("En attente",style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          )),
                  )),
                                    SizedBox(width: 10),

                    Flexible(
                  flex: 1,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.green,
                    onPressed: () {},
                    child: Text("Livré",style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          )),
                  ))
            ],
          ),
        ]..addAll(commandesWidgets(context)),
      ),
    );
  }

  List<Widget> commandesWidgets(BuildContext context) {
    return commandes
        .map((e) => CommandeItem(
              context: context,
              id: e.id,
              id_status: e.id_status,
              prix_total: e.prix_total,
              date_ajout: e.date_ajout,
              date_update: e.date_update,
            ))
        .toList();
  }
}
