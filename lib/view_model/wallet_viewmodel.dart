import 'package:flutter/material.dart';

class WalletViewModel extends ChangeNotifier {
  int _balance = 500;

  int get balance => _balance;

  bool canJoin(int entryFee) => _balance >= entryFee;

  void deduct(int amount) {
    _balance -= amount;
    notifyListeners();
  }

  void reset() {
    _balance = 500;
    notifyListeners();
  }
}