import 'package:queue_client/models/login_response.dart';

class RefreshResponseAction {
  LoginResponse response;
  RefreshResponseAction({required this.response});
}

// Define reducer
LoginResponse responseReducer(LoginResponse state, dynamic action) {
  if (action is RefreshResponseAction) {
    state = action.response;
    return state;
  }
  return state;
}
