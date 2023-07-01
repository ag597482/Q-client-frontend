import 'package:queue_client/models/entity.dart';
import 'package:queue_client/models/queue.dart';

class LoginResponse {
  Entity entity;
  List<Q> queueList;

  LoginResponse({required this.entity, required this.queueList});

  LoginResponse.fromJson(Map<String, dynamic> json)
      : entity = Entity.fromJson(json['entity']),
        queueList = getQList(json['queueList'] ?? []);
}

getQList(list) {
  List<Q> qList = [];
  for (var val in list) {
    qList.add(Q.fromJson(val));
  }
  return qList;
}
