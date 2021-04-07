import 'package:pfaMobile/models/Commande.dart';
import 'dart:convert';
import 'package:pfaMobile/URLs.dart';
import 'package:http/http.dart' as http;
import 'package:pfaMobile/models/LignePanier.dart';
import 'package:pfaMobile/session.dart';

class CommandeService {
  static Future<List<Commande>> fetchAllNotifs() async {
    final response = await http.get(notificationApi+"?id_user="+connectedUser.id);
    List<dynamic> values = json.decode(response.body);
    List<Commande> commandes = new List<Commande>();

    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          commandes.add(Commande.fromJson(map));
        }
      }
    }
    
    return commandes;
  }
static Future<List<Commande>> fetchAllCommandes(int id) async {
    final response = await http.get(commandesApi+"?id="+id.toString()+"&username="+connectedUser.username);
    List<dynamic> values = json.decode(response.body);
    print(values);
    List<Commande> commandes = new List<Commande>();
    print(commandes);
    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          commandes.add(Commande.fromJson(map));
        }
      }
    }
    return commandes;
  }

  static Future<List<LignePanier>> fetchProductsCommandes(int id) async {
    final response = await http.get(commandesApi+"?id_commande="+id.toString());
    List<dynamic> values = json.decode(response.body);
    print(values);
    List<LignePanier> lignePaniers = new List<LignePanier>();
    print(lignePaniers);
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
