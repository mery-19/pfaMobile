import 'package:pfaMobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/models/LignePanier.dart';
import 'package:pfaMobile/screens/Envies/EnvieItem.dart';
import 'package:pfaMobile/services/EnviesService.dart';

class EnviesScreen extends StatefulWidget {
  static const String routeName = "/Envies";
  static var isProductDeleted = ValueNotifier<bool>(false);

  @override
  _EnviesScreenState createState() => _EnviesScreenState();
}

class _EnviesScreenState extends State<EnviesScreen> {
  static List<LignePanier> lignePaniers = new List<LignePanier>();

  @override
  void initState() {
    super.initState();
    EnviesService.fetchAll().then((value) {
      setState(() {
        lignePaniers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste D'envies"),
        centerTitle: true,
        backgroundColor: main_bg_color,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ValueListenableBuilder(
              valueListenable: EnviesScreen.isProductDeleted,
              builder: (context, value, widget) {
                return Column(
                  children: []..addAll(productsInEnviesScreen(context)),
                );
              }),
        ),
      )),
    );
  }

  List<Widget> productsInEnviesScreen(BuildContext context) {
    return lignePaniers
        .map((e) => new EnvieItem(
              lignePanier: e,
              context1: context,
            ))
        .toList();
  }
}
