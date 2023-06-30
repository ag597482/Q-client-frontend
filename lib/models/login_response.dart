import 'package:queue_client/models/entity.dart';
import 'package:queue_client/models/queue.dart';

class LoginResponse {
  Entity entity;
  List<Q> queueList;

  LoginResponse({
    required this.entity,
    required this.queueList
  });
}
