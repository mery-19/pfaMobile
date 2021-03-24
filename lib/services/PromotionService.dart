import 'package:pfaMobile/models/Promotion.dart';
import 'dart:convert';
import 'package:pfaMobile/URLs.dart';
import 'package:http/http.dart' as http;

class PromotionService {
  static Future<List<Promotion>> fetchAll() async {
    final response = await http.get(promotionApi);
    List<dynamic> values = json.decode(response.body);
    List<Promotion> promotions = new List<Promotion>();

    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          promotions.add(Promotion.fromJson(map));
        }
      }
    }
    return promotions;
  }

  static Future<Promotion> fetchById(int id) async {
    final response = await http.get(promotionApi+"/"+id.toString());
    dynamic value = json.decode(response.body);
    return Promotion.fromJson(value);
  }
}
