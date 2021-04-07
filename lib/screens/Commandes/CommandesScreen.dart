import 'package:flutter/material.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Commande.dart';
import 'package:pfaMobile/screens/Commandes/CommandeItem.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:pfaMobile/services/CommandeService.dart';

class CommandesScreen extends StatefulWidget {
  static const String routeName = "/commandes";
  final int id;

  CommandesScreen({this.id});
  @override
  _CommandesScreenState createState() => _CommandesScreenState(id);
}

class _CommandesScreenState extends State<CommandesScreen> {
  List<Commande> commandes = new List<Commande>();
  final int id;
  _CommandesScreenState(this.id);
  @override
  void initState() {
    super.initState();
    CommandeService.fetchAllCommandes(id).then((value) {
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
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
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommandesScreen(id: 0)),
                          (route) => false);
                    },
                    child: Text("Toutes mes commandes",
                        style: TextStyle(
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
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommandesScreen(id: 1)),
                          (route) => false);
                    },
                    child: Text("En attente",
                        style: TextStyle(
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
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommandesScreen(id: 2)),
                          (route) => false);
                    },
                    child: Text("Livré",
                        style: TextStyle(
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
              context1: context,
              id: e.id,
              id_status: e.id_status,
              prix_total: e.prix_total,
              date_ajout: e.date_ajout,
              date_update: e.date_update,
            ))
        .toList();
  }
}
