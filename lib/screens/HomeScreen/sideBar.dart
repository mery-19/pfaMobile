import 'package:flutter/material.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/screens/Authentication/Signin.dart';
import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:pfaMobile/screens/Panier.dart/Panier.dart';
import 'package:pfaMobile/services/PromotionService.dart';
import 'package:pfaMobile/session.dart';

Drawer buildDrawer(BuildContext context) {
  return new Drawer(
    child: new ListView(
      children: <Widget>[
//            header
        new UserAccountsDrawerHeader(
          accountName: Text((connectedUser == null)
              ? "Nom d'utilisateur"
              : connectedUser.username),
          accountEmail:
              Text((connectedUser == null) ? "Email" : connectedUser.email),
          currentAccountPicture: GestureDetector(
            child: new ClipOval(
              child: Image.asset(
                "assets/images/avatar.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          decoration: new BoxDecoration(color: main_bg_color),
        ),

//            body

        InkWell(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomePage.routeName, (Route<dynamic> route) => false);
          },
          child: ListTile(
            title: Text(
              'Accueil',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inconsolata',
              ),
            ),
            leading: Icon(
              Icons.home,
              color: main_bg_color,
            ),
          ),
        ),

        InkWell(
          onTap: () {
            PromotionService.fetchById(3).then((value) {
              print(value);
            });
          },
          child: ListTile(
            title: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inconsolata',
              ),
            ),
            leading: Icon(
              Icons.notifications_active,
              color: main_bg_color,
            ),
          ),
        ),

        InkWell(
          onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Panier(),
                      ),
                    );
          },
          child: ListTile(
            title: Text(
              'Mon panier',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inconsolata',
              ),
            ),
            leading: Icon(
              Icons.shopping_cart,
              color: main_bg_color,
            ),
          ),
        ),

        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'Mes commandes',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inconsolata',
              ),
            ),
            leading: Icon(
              Icons.shopping_basket,
              color: main_bg_color,
            ),
          ),
        ),

        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'Envies',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inconsolata',
              ),
            ),
            leading: Icon(
              Icons.favorite,
              color: main_bg_color,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'Mon compte',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inconsolata',
              ),
            ),
            leading: Icon(
              Icons.person,
              color: main_bg_color,
            ),
          ),
        ),
        Divider(),
        Visibility(
          visible: true,
          child: InkWell(
            child: ListTile(
              title: Text(
                (connectedUser == null) ? 'Se connecter' : 'Déconnexion',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Inconsolata',
                ),
              ),
              leading: Icon(
                (connectedUser == null) ? Icons.login : Icons.logout,
                color: Colors.grey,
              ),
              onTap: (){
                if (connectedUser == null)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signin(),
                      ),
                    );
                  }else{
                    logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                HomePage.routeName, (Route<dynamic> route) => false);
                  }
              },
            ),
          ),
        ),

        Visibility(
          visible: false,
          child: InkWell(
            onTap: () {},
            child: ListTile(
              title: Text(
                'Log out',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Inconsolata',
                ),
              ),
              leading: Icon(
                Icons.transit_enterexit,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
