import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/entity.dart';
import '../models/login_response.dart';
import '../models/queue.dart';
import '../screens/home.dart';

class Util {
  static void showToast(errorMesage) {
    Fluttertoast.showToast(
      msg: errorMesage,
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast message
      gravity: ToastGravity.BOTTOM, // Location where the toast message appears
      timeInSecForIosWeb:
          1, // Duration of the toast message for iOS and web platforms
      backgroundColor: Colors.black87, // Background color of the toast message
      textColor: Colors.white, // Text color of the toast message
    );
  }

  static Future<LoginResponse> getEntityDetailsVerify(Entity entity) async {
    // Make the API request to fetch messages
    // Replace 'your_api_endpoint' with the actual API endpoint URL
    // password=%s&phoneNumber=%s
    var response = await http.get(Uri.parse(
        "$baseUrl${logInEntityByPhoneNumberUrl}password=${entity.password!}&phoneNumber=${entity.phoneNumber!}"));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(jsonResponse);
      return loginResponse;
    } else {
      print(response.body);
      print('Failed to fetch messages. Error: ${response.statusCode}');
      throw exitCode;
    }
  }

  static void createQ(Q q, Entity entity, context) async {
    var url = Uri.parse(baseUrl + addQUrl + entity.id!);
    print(url.toString());
    var jsonBody = json.encode([q.toJson()]);
    print(jsonBody);

    var headers = {'Content-Type': 'application/json'};
    // Send the POST request
    var response = await http.post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      print('Request successful!');
      // StoreProvider.of<LoginResponse>(context).dispatch(UpdateAction(entity: entity));
      // Navigator.of(context)
      //     .pushAndRemoveUntil(CupertinoPageRoute(builder: (ctx) => HomeScreen()));
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomeScreen(entity: entity),
      //   ),
      //   (route) => false,
      // );
      print('Response: ${response.body}');
    } else {
      var jsonResponse = json.decode(response.body);
      Util.showToast(jsonResponse['message']);
      print(response.body);
      print('Request failed with status: ${response.statusCode}');
    }
  }

  static void removeQ(qId, Entity entity, context) async {
    var url = Uri.parse(baseUrl + removeQUrl + entity.id!);
    var jsonBody = json.encode([qId]);
    print(jsonBody);
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      print('Request successful!');
      print('Response: ${response.body}');
    } else {
      var jsonResponse = json.decode(response.body);
      Util.showToast(jsonResponse['message']);
      print(response.body);
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
