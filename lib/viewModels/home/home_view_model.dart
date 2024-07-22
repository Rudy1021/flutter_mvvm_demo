import 'package:flutter/material.dart';

import '../../models/home/home.dart';

class HomeViewModel extends ChangeNotifier {
  Home home = Home(counter: 0);

  num get counter => home.counter;

  void incrementCounter() {
    home.counter++;
    notifyListeners();
  }
}
