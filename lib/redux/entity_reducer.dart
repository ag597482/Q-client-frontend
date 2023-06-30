import 'dart:convert';
import 'package:queue_client/models/entity.dart';
import '../constants.dart';
import '../utils/shared_pref_helper.dart';

// Define actions
class UpdateAction {
  Entity entity;
  UpdateAction({required this.entity});
}

class RefreshAction {
  Entity entity;
  RefreshAction({required this.entity});
}

// Define reducer
Entity entityReducer(Entity state, dynamic action) {
  SharedPreferenceService service = SharedPreferenceService();
  if (action is UpdateAction) {
    state = action.entity;
    String taskString = json.encode(state);
    service.updateStringVal(entityDBKey, taskString);
    return state;
  }
  else if (action is RefreshAction) {
    state = action.entity;
    return state;
  }
  return state;
}
