import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:queue_client/screens/appdrawer.dart';
import 'package:queue_client/screens/login.dart';
import 'package:queue_client/screens/profile.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/entity.dart';
import '../redux/entity_reducer.dart';
import '../utils/shared_pref_helper.dart';

class HomeScreen extends StatelessWidget {
  Entity entity;
  HomeScreen({required this.entity});

  getEntityDetailsVerify(Entity entity) async {
    // Make the API request to fetch messages
    // Replace 'your_api_endpoint' with the actual API endpoint URL
    // password=%s&phoneNumber=%s
    var response = await http.get(Uri.parse(
        "$baseUrl${logInEntityByPhoneNumberUrl}password=${entity.password!}&phoneNumber=${entity.phoneNumber!}"));

    if (response.statusCode == 200) {
      var entity = json.decode(response.body);
      return entity;
    } else {
      print('Failed to fetch messages. Error: ${response.statusCode}');
      throw exitCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: getAppDrawer(),
      body: FutureBuilder<dynamic>(
        future: getEntityDetailsVerify(entity),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Entity entity = Entity();
            if (snapshot.data! != "") {
              entity = Entity.fromJson(snapshot.data!['entity']);
              StoreProvider.of<Entity>(context)
                  .dispatch(RefreshAction(entity: entity));
            }
            return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                child: StoreConnector<Entity, Entity>(
                    converter: (Store<Entity> store) {
                  return store.state;
                }, builder: (BuildContext context, Entity entity) {
                  return Column(
                    children: [
                      Text(entity.toJson().toString()),
                      Text(entity.toJson().toString()),
                      Text(entity.toJson().toString())
                    ],
                  );
                }));
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:queue_client/screens/profile.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProfileScreen(
                    
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('Home Screen'),
//       ),
//     );
//   }
// }