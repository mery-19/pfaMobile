
import 'package:pfaMobile/models/Product.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfaMobile/screens/Panier/Panier.dart';
import 'package:pfaMobile/screens/Product/productDetail.dart';


// We use name route
// All our routes will be available here
// final Map<String, WidgetBuilder> routes = {
//   Signup.routeName: (context) => Signup(),

// };

RouteFactory routes() {
  Product product = new Product();
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case HomePage.routeName:
        screen = HomePage();
        break;
      
      case ProductDetail.routeName:
        screen = ProductDetail(product);
        break;

       case Panier.routeName:
        screen = Panier();
        break;
        
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
