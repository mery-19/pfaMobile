import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Category.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String libele;
  final String image;
  final int id;


  CategoryItem({this.libele, this.image, this.id});

  List<Category> categories = new List<Category>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
         onTap: () {
          HomePage.id_category.value = id;
          HomePage.label_category.value = libele;

        },
        child: Container(
          width: 150.0,
          child: ListTile(
              title: Image.network(server+"Uploads/Categorie_image/"+this.image,
                width: 70.0,
                height: 40.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  libele,
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Inconsolata',
                    fontWeight: FontWeight.bold,
                    color:main_bg_color,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
