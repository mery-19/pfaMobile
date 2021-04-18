import 'package:pfaMobile/models/LignePanier.dart';
import 'dart:convert';
import 'package:pfaMobile/URLs.dart';
import 'package:http/http.dart' as http;
import 'package:pfaMobile/session.dart';

class EnviesService {
  static Future<List<LignePanier>> fetchAll() async {
    final response =
        await http.get(enviesApi + "?username=" + connectedUser.username);
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

  static Future<bool> delete(int id) async {
    final response = await http.delete(enviesApi +
        "?id_user=" +
        connectedUser.id +
        "&id_produit=" +
        id.toString());
    dynamic value = json.decode(response.body);
    print("'''''''''''''''''''''''''''''''");
    print(response.body);
    print(value);
    print("'''''''''''''''''''''''''''''''");
    return true;
  }

    static Future<bool> add(int id) async {
    final response = await http.get(enviesApi +
        "?id_user=" +
        connectedUser.id +
        "&id_produit=" +
        id.toString());
    dynamic value = json.decode(response.body);
    print("'''''''''''''''''''''''''''''''");
    print(response.body);
    print(value);
    print("'''''''''''''''''''''''''''''''");
    return true;
  }
}
