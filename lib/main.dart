import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/page/home/home.dart';
import 'package:flutter_mvvm_demo/viewModels/initialize/initialize_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => InitializeViewModel(),
      child: const MaterialApp(
        home: HomePage(),
      )));
}
