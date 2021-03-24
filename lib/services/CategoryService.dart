import 'package:pfaMobile/models/Category.dart';
import 'dart:convert';
import 'package:pfaMobile/URLs.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static Future<List<Category>> fetchAllCategory() async {
    final response = await http.get(categoryApi);
    List<dynamic> values = json.decode(response.body);
    List<Category> categories = new List<Category>();

    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          categories.add(Category.fromJson(map));
        }
      }
    }
    
    return categories;
  }

  static fetchCategoryById(int id) async {
    final response = await http.get(categoryApi + "?id=" + id.toString());
    Map<String, dynamic> values = json.decode(response.body);

    if (values['status'] == 200) {
      Category category = new Category();
      category = Category.fromJson(values['data'][0]);

      return category.libele;
    } else
      return "category not found";
  }
}
