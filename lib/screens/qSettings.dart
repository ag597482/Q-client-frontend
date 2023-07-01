import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:queue_client/models/entity.dart';
import 'package:queue_client/redux/response_reducer.dart';
import 'package:redux/redux.dart';

import '../models/login_response.dart';
import '../models/queue.dart';
import '../utils/util.dart';
import 'home.dart';

class QSettingScreen extends StatelessWidget {
  Entity entity;
  QSettingScreen({super.key, required this.entity});

  openDialog(context) {
    TextEditingController nameTextController = TextEditingController();
    TextEditingController descriptionTextController = TextEditingController();
    TextEditingController startRangeTextController = TextEditingController();
    TextEditingController endRangeTextController = TextEditingController();
    TextEditingController maxInQueueLimitTextController =
        TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("ADD"),
            content: Container(
              alignment: Alignment.center,
              height: 240,
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    controller: nameTextController,
                    decoration: const InputDecoration(hintText: 'Enter Q Name'),
                  ),
                  TextField(
                    autofocus: true,
                    controller: descriptionTextController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Q Description'),
                  ),
                  TextField(
                    autofocus: true,
                    controller: startRangeTextController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Start Range of Q (optional)'),
                  ),
                  TextField(
                    autofocus: true,
                    controller: endRangeTextController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'End Range of Q (optional)'),
                  ),
                  TextField(
                    autofocus: true,
                    controller: maxInQueueLimitTextController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Enter Q limit (optional)'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (nameTextController.text.isEmpty) {
                      _showSnackBar(context, 'Invalid name entered');
                    } else {
                      Q newQ = Q(
                          name: nameTextController.text,
                          description: descriptionTextController.text,
                          startRange: startRangeTextController.text.isNotEmpty
                              ? int.parse(startRangeTextController.text)
                              : null,
                          endRange: endRangeTextController.text.isNotEmpty
                              ? int.parse(endRangeTextController.text)
                              : null,
                          maxInQueueLimit: maxInQueueLimitTextController
                                  .text.isNotEmpty
                              ? int.parse(maxInQueueLimitTextController.text)
                              : null);
                      createQueue(newQ, entity, context);
                      _showSnackBar(context, 'Queue created successfully');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(entity: entity),
                        ),
                        (route) => false,
                      );
                    }
                    // submit(dialogTextController.text, title);
                  },
                  child: const Text("Create"))
            ],
          );
        });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void createQueue(newQ, entity, context) {
    Navigator.of(context).pop();
    Util.createQ(newQ, entity, context);

    // Exersise exersise = Exersise(text,
    //     DateFormat.yMMMd().format(DateTime.now()), 0, title, 0, 0, 0, 0, 0, 0);
    // _save(exersise);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: Store<LoginResponse>(responseReducer,
            initialState: LoginResponse(entity: entity, queueList: [])),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Q Settings"),
            actions: [
              IconButton(
                  onPressed: () {
                    openDialog(context);
                  },
                  icon: const Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                  ))
            ],
          ),
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
                LoginResponse response = snapshot.data!;
                StoreProvider.of<LoginResponse>(context)
                    .dispatch(RefreshResponseAction(response: response));
                return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    child: StoreConnector<LoginResponse, List<Q>>(
                        converter: (Store<LoginResponse> store) {
                      return store.state.queueList;
                    }, builder: (BuildContext context, List<Q> queueList) {
                      return ListView.builder(
                          itemCount: queueList.length,
                          itemBuilder: (BuildContext context, int position) {
                            return Card(
                                color: Colors.white,
                                elevation: 2.0,
                                child: ListTile(
                                  autofocus: true,
                                  title: Text(queueList[position].name!),
                                  subtitle:
                                      Text(queueList[position].description!),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      Util.removeQ(queueList[position].id,
                                          entity, context);
                                      queueList.removeAt(position);
                                      StoreProvider.of<LoginResponse>(context)
                                          .dispatch(RefreshResponseAction(
                                              response: LoginResponse(
                                                  entity: entity,
                                                  queueList: queueList)));
                                      _showSnackBar(context,
                                          'Queue deleted successfully');
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         HomeScreen(entity: entity),
                                      //   ),
                                      //   (route) => false,
                                      // );
                                    },
                                  ),
                                ));
                          });

                      // Column(
                      //   children: [
                      //     Text(queueList.length.toString()),
                      //     Text(entity.toJson().toString()),
                      //   ],
                      // );
                    }));
              }
            },
          ),
        ));
  }
}
