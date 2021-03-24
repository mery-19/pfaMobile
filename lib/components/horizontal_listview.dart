import 'package:pfaMobile/components/category_item.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Category.dart';
import 'package:pfaMobile/services/CategoryService.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';

class HorizontalList extends StatefulWidget {
  HorizontalList() : super();
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  List<Category> categories = new List<Category>();

  @override
  void initState() {
    super.initState();
    CategoryService.fetchAllCategory().then((value) {
      setState(() {
        categories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () {
                HomePage.id_category.value = 0;
                HomePage.label_category.value = "Tous";
              },
              child: Container(
                width: 100.0,
                child: ListTile(
                    title: Image.asset(
                      "assets/images/allCateg.jpg",
                      width: 70.0,
                      height: 40.0,
                    ),
                    subtitle: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Tous",
                        style: new TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Inconsolata',
                            fontWeight: FontWeight.bold,
                            color: main_bg_color),
                      ),
                    )),
              ),
            ),
          ),
        ]..addAll(categorySection()),
      ),
    );
  }

  List<Widget> categorySection() {
    return categories
        .map((e) => CategoryItem(libele: e.libele, image: e.image, id: e.id))
        .toList();
  }
}
