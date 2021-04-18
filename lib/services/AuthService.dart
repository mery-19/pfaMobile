

import 'dart:convert';

import 'package:pfaMobile/URLs.dart';
import 'package:pfaMobile/constants.dart';
import 'package:pfaMobile/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:pfaMobile/services/EnviesService.dart';
import 'package:pfaMobile/session.dart';

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
    print("************* USER START ******************");
    print(value);
    print("************* USER END ******************");
    
    connectedUser =(value != null)? User.fromJson(value):null;
  
    return connectedUser;
    }

}