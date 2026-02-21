import 'package:flutter/material.dart';
import 'package:technical_task/utils/app_routes.dart';
import '../model/user_model.dart';
import '../utils/auth_api.dart';
import '../utils/token_storage.dart';

class AuthViewModel extends ChangeNotifier {

  bool isLoading = false;
  String? error;
  UserModel? user;

  bool get isAuthenticated => user != null;

  bool _isValidUsername(String username) {
    return username.trim().isNotEmpty && username.trim().length >= 3;
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<bool> login({
    required String userName,
    required String password,
    required String email,
  }) async {

    if (!_isValidUsername(userName)) {
      error = 'Username must be at least 3 characters';
      notifyListeners();
      return false;
    }

    if (!_isValidEmail(email)) {
      error = 'Please enter a valid email address';
      notifyListeners();
      return false;
    }

    if (!_isValidPassword(password)) {
      error = 'Password must be at least 6 characters';
      notifyListeners();
      return false;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await AuthApi.login(
        userName: userName,
        password: password,
      );

      final token = response['accessToken'] as String;

      user = UserModel(
        userName: userName,
        email: email,
        token: token,
      );

      await TokenStorage.saveToken(token);

      return true;
    } catch (e) {
      error = 'Invalid email or password';
      print("Invalid email or password :- ${e.toString()}");
      return false;
    } finally {
      isLoading = false;
      error = null;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await TokenStorage.clear();
    user = null;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    try {
      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) return false;

      final profile = await AuthApi.fetchProfile(token);

      user = UserModel(
        userName: profile['username'],
        email: profile['email'],
        token: token,
      );

      notifyListeners();
      return true;
    } catch (e) {
      await TokenStorage.clear();
      return false;
    }
  }

}