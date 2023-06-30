import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:queue_client/models/entity.dart';
import 'package:queue_client/redux/entity_reducer.dart';
import 'package:queue_client/screens/splash.dart';
import 'package:queue_client/utils/shared_pref_helper.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      SharedPreferenceService service = SharedPreferenceService();
      return FutureBuilder<String>(
        future: service.getStringVal(entityDBKey),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Entity entity = Entity();
            if (snapshot.data! != "") {
              entity = Entity.fromJson(json.decode(snapshot.data!));
            }

            return StoreProvider(
              store: Store<Entity>(entityReducer, initialState: entity),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Q Client',
                theme: ThemeData(primarySwatch: Colors.blueGrey),
                home: SplashScreen(isLoggedIn: entity.isLoggedIn ?? false, entity: entity),
              ),
            );
          }
        },
      );
    }

  //   return MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       title: 'Q Client',
  //       theme: ThemeData(primarySwatch: Colors.blueGrey),
  //       home: LoginScreen());
  // }
}
