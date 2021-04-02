import 'package:pfaMobile/models/LignePanier.dart';
import 'dart:convert';
import 'package:pfaMobile/URLs.dart';
import 'package:http/http.dart' as http;
import 'package:pfaMobile/session.dart';

class PanierService {
  static Future<List<LignePanier>> fetchAll() async {
    final response =
        await http.get(panierApi + "?username=" + connectedUser.username);
    List<dynamic> values = json.decode(response.body);
    List<LignePanier> lignePaniers = new List<LignePanier>();

    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          lignePaniers.add(LignePanier.fromJson(map));
        }
      }
    }
    return lignePaniers;
  }

  static Future<LignePanier> updateQuantite(int id_produit, int qty) async {
    try {
      final response = await http.put(
        panierApi,
        body: {
          'id_user': connectedUser.id,
          'id_produit': id_produit,
          'qty': qty
        },
        headers: {"Accept": "application/json"},
      );

      dynamic value = json.decode(response.body);

      return LignePanier.fromJson(value);
    } catch (e) {
      print("------*********---------********");
      print(e.toString());
      print("------*********---------********");
    }
  }
}
