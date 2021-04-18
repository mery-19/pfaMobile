import 'package:pfaMobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/session.dart';

class CompteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes informations"),
        centerTitle: true,
        backgroundColor: main_bg_color,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            buildCard(Icons.person, connectedUser.username),
            buildCard(Icons.mail, connectedUser.email),
            buildCard(Icons.home ,connectedUser.address),
            buildCard(Icons.phone, connectedUser.phone),
          ]),
        )),
      ),
    );
  }

  Card buildCard(IconData icon,String text) {
    return Card(
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
                            Icon(
                              icon,
                              color: main_bg_color_2,
                              size: 50.0,
                            ),
                            SizedBox(width: height_box),
                            Text(text,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
