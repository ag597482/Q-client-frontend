import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:queue_client/constants.dart';
import 'package:queue_client/models/entity.dart';
import 'package:http/http.dart' as http;
import 'package:queue_client/screens/home.dart';

import '../redux/entity_reducer.dart';
import '../utils/util.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void createEntityPostRequest(Entity entity, context) async {
    var url = Uri.parse(
        // "http://ec2-13-127-142-88.ap-south-1.compute.amazonaws.com:9999/addEntity"
        baseUrl + createEntity);

    // Create the request body
    // var body = {
    //   'id': 12,
    //   'name': entity.name,
    //   'phoneNumber': entity.phoneNumber,
    //   'password': entity.password
    // };
    // var jsonBody = json.encode(body);
    var jsonBody = json.encode(entity.toJson());
    print(jsonBody);

    var headers = {'Content-Type': 'application/json'};
    // Send the POST request
    var response = await http.post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      print('Request successful!');
      entity.isLoggedIn = true;
      StoreProvider.of<Entity>(context).dispatch(UpdateAction(entity: entity));
      // Navigator.of(context)
      //     .pushAndRemoveUntil(CupertinoPageRoute(builder: (ctx) => HomeScreen()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(entity: entity),
        ),
        (route) => false,
      );
      print('Response: ${response.body}');
    } else {
      var jsonResponse = json.decode(response.body);
      Util.showToast(jsonResponse['message']);
      print(response.body);
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    } else if (value!.length != 10) {
                      return 'Please enter a valid 10 digit phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Entity entity = Entity.init(
                          name: _nameController.text,
                          phoneNumber: _phoneNumberController.text,
                          password: _passwordController.text,
                          isLoggedIn: true);
                      createEntityPostRequest(entity, context);
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Already have an account? Log in here',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
