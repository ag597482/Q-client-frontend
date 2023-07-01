import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:queue_client/screens/profile.dart';
import 'package:queue_client/screens/qSettings.dart';
import 'package:redux/redux.dart';

import '../models/entity.dart';
import '../redux/entity_reducer.dart';
import 'login.dart';

getDrawerHeader() {
  return const DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.blue,
    ),
    child: Center(
      child: Text(
        'App Drawer',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
    ),
  );
}

getDivider() {
  return const Divider(
    height: 2,
    thickness: 1.0,
    indent: 5,
    endIndent: 5,
  );
}

getProfileOption(context) {
  return ListTile(
    leading: const Icon(Icons.person),
    title: const Text('Profile'),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      );
    },
  );
}

getQSettingOption(context, Entity entity) {
  return ListTile(
    leading: const Icon(Icons.settings),
    title: const Text('Q Settings'),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QSettingScreen(
            entity: entity,
          ),
        ),
      );
    },
  );
}

getSignOutOption(context, Entity entity) {
  return ListTile(
    iconColor: Colors.red,
    textColor: Colors.red,
    leading: const Icon(Icons.login_outlined),
    title: const Text('Logout'),
    onTap: () {
      entity.isLoggedIn = false;
      StoreProvider.of<Entity>(context).dispatch(UpdateAction(entity: entity));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false,
      );
    },
  );
}

getAppDrawer() {
  return Drawer(
      child: StoreConnector<Entity, Entity>(converter: (Store<Entity> store) {
    return store.state;
  }, builder: (BuildContext context, Entity entity) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        getDrawerHeader(),
        getProfileOption(context),
        getDivider(),
        getQSettingOption(context, entity),
        getDivider(),
        getSignOutOption(context, entity)
      ],
    );
  }));
}
