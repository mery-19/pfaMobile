import 'package:flutter/material.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Commande.dart';
import 'package:pfaMobile/screens/Notifications/NotificationItem.dart';
import 'package:pfaMobile/services/CommandeService.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = "/books_store";

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
   List<Commande> notifications = new List<Commande>();

  @override
  void initState() {
    super.initState();
    CommandeService.fetchAllNotifs().then((value) {
      setState(() {
        notifications = value;
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
          "Books notifs",
          style: TextStyle(
            fontSize: headline6_size,
            fontFamily: 'Inconsolata',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: []..addAll(notifs()),
      ),
    );
  }

    List<Widget> notifs() {
    return notifications
        .map((e) => NotificationItem(
             context: context,
              id: e.id.toString(),
              date_update: e.date_update,
            ))
        .toList();
  }
}
