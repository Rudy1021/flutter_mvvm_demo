import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/page/home/home.dart';
import 'package:flutter_mvvm_demo/viewModels/initialize/initialize_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  InitializeViewModel initializeViewModel = InitializeViewModel();
  await initializeViewModel.init();

  runApp(ChangeNotifierProvider(
      create: (_) => initializeViewModel,
      child: const MaterialApp(
        home: HomePage(),
      )));
}
