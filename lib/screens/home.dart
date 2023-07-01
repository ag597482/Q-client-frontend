import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:queue_client/models/login_response.dart';
import 'package:queue_client/screens/appdrawer.dart';
import 'package:redux/redux.dart';
import '../models/entity.dart';
import '../redux/entity_reducer.dart';
import '../utils/util.dart';

class HomeScreen extends StatelessWidget {
  Entity entity;
  HomeScreen({required this.entity});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: getAppDrawer(),
      body: FutureBuilder<LoginResponse>(
        future: Util.getEntityDetailsVerify(entity),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Entity entity = Entity();
            // if (snapshot.data! != "") {
            entity = snapshot.data!.entity;
            StoreProvider.of<Entity>(context)
                .dispatch(RefreshAction(entity: entity));
            // }
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