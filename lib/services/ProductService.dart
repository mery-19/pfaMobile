import 'dart:convert';
import 'package:pfaMobile/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/session.dart';

class ProductService {
  

  static Future<List<Product>> fetchAll() async {
    try {
      List<dynamic> values = new List<dynamic>();
      List<Product> ProductsList = new List<Product>();
      final response = await http.get(produitsApi);
      values = json.decode(response.body);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            try {
              ProductsList.add(Product.fromJson(map));
            } catch (e) {
              print(e.toString());
              throw Exception(e.toString());
            }
          }
        }
      }
       return ProductsList;
    } catch (e) {
      print("*********** Error here *****************");
      print(e.toString());
      throw Exception(e.toString());
    }
  }

    static Future<List<Product>> fetchByCategory(int id) async {
    try {
      List<dynamic> values = new List<dynamic>();
      List<Product> ProductsList = new List<Product>();


      final response = await http.get(produitsApi+"?id_cat="+id.toString());
      values = json.decode(response.body);
     
      //print(values);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            try {
              ProductsList.add(Product.fromJson(map));
            } catch (e) {
              print("*********** Error *****************");
              print(e.toString());
              throw Exception(e.toString());
            }
          }
        }
      }
       return ProductsList;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

     static Future<List<Product>> fetchTop() async {
    try {
      List<dynamic> values = new List<dynamic>();
      List<Product> ProductsList = new List<Product>();


      final response = await http.get(produitsApi+"?top=top");
      values = json.decode(response.body);
     
      //print(values);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            try {
              ProductsList.add(Product.fromJson(map));
            } catch (e) {
              print("*********** Error *****************");
              print(e.toString());
              throw Exception(e.toString());
            }
          }
        }
      }
       return ProductsList;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

   static Future<int> getProductQty(int id_produit) async {
    try {
      final response = await http.get(
        produitsApi+"?name="+connectedUser.username+"&id_produit="+id_produit.toString(),
        
        headers: {"Accept": "application/json"},
      );
      dynamic value = response.body;
      print("val: "+value);
      return int.parse(value);

    } catch (e) {
      print("*************** ERROR PRODUCT ADD START ****************");
      print(e.toString());
      print("*************** ERROR  PRODUCT ADD END ****************");
    }
    return 0;
  }

}
