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

  
}
