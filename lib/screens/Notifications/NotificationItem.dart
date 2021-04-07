import 'package:flutter/material.dart';
import 'package:pfaMobile/constants.dart';

class NotificationItem extends StatelessWidget {
  final BuildContext context;
  final String id;
  final String date_update;

  NotificationItem({this.context, this.id, this.date_update});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SizedBox(height: height_box),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text(
                "Status de commande de Numéro d'id " +
                    id +
                    " à été change de 'En attente' à 'Livré'",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Divider(),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      date_update.split("T")[0],
                      style: buildTextStyle(),
                    ),
                  ],
                )),
          ],
        ),
      ),
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: main_bg_color,
            blurRadius: 5.0,
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
      fontSize: 20,
    );
  }
}
