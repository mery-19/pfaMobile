import 'dart:convert';
import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/Product.dart';
import 'package:pfaMobile/models/Promotion.dart';
import 'package:pfaMobile/screens/HomeScreen/ProductCell.dart';
import 'package:pfaMobile/screens/HomeScreen/sideBar.dart';
import 'package:pfaMobile/screens/Product/arguments.dart';
import 'package:pfaMobile/screens/Product/productDetail.dart';
import 'package:pfaMobile/services/ProductService.dart';
import 'package:flutter/material.dart';
import 'package:pfaMobile/services/PromotionService.dart';
import '../../components/horizontal_listview.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage() : super();
  static const String routeName = "/home";
  static final id_category = ValueNotifier<int>(0);
  static final label_category = ValueNotifier<String>("Tous");
  static List<Promotion> promotions;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnectVisible = true;
  int i = 0;

  // For Search Bar START
  final TextEditingController filter = new TextEditingController();
  String searchText = "";
  List filterProducts = new List(); // names filtered by search text
  List productsList = new List();
  Icon searchIcon = new Icon(Icons.search);
  Widget appBarTitle = null;

  void getNames() async {
    final response = await http.get(produitsApi);
        productsList = json.decode(response.body);
        setState(() {
          productsList.shuffle();
          filterProducts = productsList;
        });
  }

  void _searchPressed() {
    setState(() {
      if (this.searchIcon.icon == Icons.search) {
        this.searchIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          controller: filter,
          decoration: new InputDecoration(hintText: 'Search...'),
        );
      } else {
        this.searchIcon = new Icon(Icons.search);
        this.appBarTitle = null;
        filterProducts = productsList;
        filter.clear();
      }
    });
  }

  Widget _buildList() {
    if (!(searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filterProducts.length; i++) {
        if (filterProducts[i]['name']
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          tempList.add(filterProducts[i]);
        }
      }
      filterProducts = tempList;
    }
    //return null;
    return ListView.builder(
      itemCount: productsList == null ? 0 : filterProducts.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filterProducts[index]['name']),
          onTap: () {
             Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(Product.fromJson(filterProducts[index])),
                          settings: RouteSettings(
                              arguments: ScreenArguments(0)),
                        ),
                      );
          },
        );
      },
    );
  }

  _HomePageState() {
    filter.addListener(() {
      if (filter.text.isEmpty) {
        setState(() {
          searchText = "";
          filterProducts = productsList;
        });
      } else {
        setState(() {
          searchText = filter.text;
        });
      }
    });
  }
  // For Search Bar END

  @override
  void initState() {
    super.initState();
    getNames();
    PromotionService.fetchAll().then((value){
      HomePage.promotions = value;
      print("----------------START------------------");
      print(HomePage.promotions);
      print("----------------END------------------");
    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    HomePage.id_category.value = 0;
  }

  gridview(AsyncSnapshot<List<Product>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: (snapshot.data.length == 0)
          ? Center(
              child: Text(
                "La liste des produits est vide.",
                textAlign: TextAlign.center,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: snapshot.data.map(
                (product) {
                  return GestureDetector(
                    child: GridTile(
                      child: ProductCell(product),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(product),
                          settings: RouteSettings(
                              arguments: ScreenArguments(0)),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: main_bg_color,
        title: (appBarTitle != null)
            ? appBarTitle
            : Text(
                'MF Store',
                style: TextStyle(
                  fontSize: headline6_size,
                  fontFamily: 'Inconsolata',
                ),
              ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                (appBarTitle != null) ? Icons.close : Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                _searchPressed();
              }),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
              
              })
        ],
      ),
      
      drawer: buildDrawer(context),
      
      body: (appBarTitle != null)
          ? Container(
              child: _buildList(),
            )
          : new Column(
              children: <Widget>[
                //padding widget
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Inconsolata',
                        ),
                      )),
                ),

                //Horizontal list view begins here
               HorizontalList(),               

                //padding widget
                new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                        valueListenable: HomePage.id_category,
                        builder: (context, value, widget) {
                          return Text(
                            HomePage.label_category.value,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Inconsolata',
                            ),
                          );
                        })),

                //grid view
                Flexible(
                    child: ValueListenableBuilder(
                        valueListenable: HomePage.id_category,
                        builder: (context, value, widget) {
                          return FutureBuilder<List<Product>>(
                              future:(HomePage.id_category.value == 0)? ProductService.fetchAll()
                              : ProductService.fetchByCategory(HomePage.id_category.value),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error ${snapshot.error}');
                                }
                                //
                                if (snapshot.hasData) {
                                  snapshot.data.map((e) {
                                  });
                                  return gridview(snapshot);
                                }
                                return circularProgress();
                              });

                          //add here
                        })),
              ],
            ),
    );
  }
}
