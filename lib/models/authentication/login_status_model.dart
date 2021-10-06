import 'package:flutter/foundation.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class LoginModel {
  Status _status = Status.Unauthenticated;
  get status => _status;
  set status(status) {
    _status = status;
  }

  LoginModel();
}
