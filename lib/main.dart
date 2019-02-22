import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ApiHttpRequest.getAll();
    return MaterialApp(
      title: "test",
      home: Scaffold(
        appBar: AppBar(
          title: Text('data'),
        ),
        body: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}

class ApiHttpRequest {
  static Future getAll() async {
    var client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String url = 'https://10.0.2.2:44369/api/users/2';
    print('awaiting get request');
    var request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    var response = await request.close();
    
    var data = new Map<String, dynamic>();
    var responseBody = await response.transform(utf8.decoder).join();
    data = json.decode(responseBody);
    var users = new List<User>();
    print(data['roles'][0]['role']['name']);
    var user = new User();
    user.FirstName = data['firstName'];
    user.LastName = data['lastName'];
    user.Username = data['username'];
    users.add(user);
    users.forEach((user) =>
        print(user.FirstName + " | " + user.LastName + " | " + user.Username));
  }
}

class User {
  String firstName;
  String get FirstName => firstName;
  set FirstName(String FirstName) {
    firstName = FirstName;
  }

  String lastName;
  String get LastName => lastName;
  set LastName(String LastName) {
    lastName = LastName;
  }

  String username;
  String get Username => username;
  set Username(String Username) {
    username = Username;
  }

  User();
}
