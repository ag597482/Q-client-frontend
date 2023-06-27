// import 'package:flutter/material.dart';
// import 'package:queue_client/screens/profile.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Center(
//                 child: Text(
//                   'App Drawer',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24.0,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProfileScreen(
//                       name: 'John Doe', // Replace with actual name
//                       phoneNumber: '1234567890', // Replace with actual phone number
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Text('Home Screen'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:queue_client/screens/profile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    name: 'John Doe', // Replace with actual name
                    phoneNumber: '1234567890', // Replace with actual phone number
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}