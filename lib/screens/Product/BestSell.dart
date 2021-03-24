import 'package:flutter/material.dart';
import 'package:pfaMobile/models/Product.dart';
import 'package:pfaMobile/screens/HomeScreen/ProductCell.dart';
import 'package:pfaMobile/screens/Product/producItem.dart';

import 'package:pfaMobile/services/ProductService.dart';

class BestSell extends StatefulWidget {
  BestSell() : super();
  @override
  _BestSellState createState() => _BestSellState();
}

class _BestSellState extends State<BestSell> {
  List<Product> products = new List<Product>();
  @override
  void initState() {
    super.initState();
    ProductService.fetchTop().then((value){
      setState(() {
        products = value;
        print(products);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
        ]..addAll(productsSection()),
      ),
    );
  }

  List<Widget> productsSection() {
    return products
        .map((e) => ProductItem(e))
        .toList();
  }
}
