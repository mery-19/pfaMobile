

import 'dart:convert';

import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/models/User.dart';
import 'package:http/http.dart' as http;

class AuthService{
  static Future<User> login(String email, String password) async {
     final response = await http.post(authApi,
     body: {
      'Email': email,
      'Password':password
    },
     headers:{
          "Accept": "application/json"
    },
    );
    dynamic value = json.decode(response.body);
    User connectedUser = User.fromJson(value);

    print("------------Connected User------------");
    print(value);
    print(connectedUser);
    print("------------Connected User------------");

    return connectedUser;
    }

}