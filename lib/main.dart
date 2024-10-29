import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/page/home/home.dart';
import 'package:flutter_mvvm_demo/viewModels/global/global_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalViewModel initializeViewModel = GlobalViewModel();
  await initializeViewModel.init();

  runApp(ChangeNotifierProvider(
      create: (_) => initializeViewModel,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      )));
}
