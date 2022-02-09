import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  String token = '';
  String id = '';
  String username = '';
  String email = '';
  String verified = 'pending';
  bool admin = false;

  get isAdmin => admin;
  get isVerified => verified == 'verified';

  void setAll({
    required String newToken,
    required String newId,
    required String newUsername,
    required String newEmail,
    required String newVerified,
    required bool newAdmin,
  }) {
    token = newToken;
    id = newId;
    username = newUsername;
    email = newEmail;
    verified = newVerified;
    admin = newAdmin;
    notifyListeners();
  }

  void setToken(String v) {
    token = v;
    notifyListeners();
  }

  void setId(String v) {
    id = v;
    notifyListeners();
  }

  void setUsername(String v) {
    username = v;
    notifyListeners();
  }

  void setEmail(String v) {
    email = v;
    notifyListeners();
  }

  void setVerified(String v) {
    verified = v;
    notifyListeners();
  }

  void setAdmin(bool v) {
    admin = v;
    notifyListeners();
  }
}
