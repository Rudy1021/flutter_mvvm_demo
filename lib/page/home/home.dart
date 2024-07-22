import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/home/home_view_model.dart';
import '../../viewModels/initialize/initialize_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InitializeViewModel initializeViewModel = InitializeViewModel();
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeViewModel = context.read<InitializeViewModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => homeViewModel,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("首頁"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Consumer(builder: (context, HomeViewModel viewModel, child) {
                  return Text(
                    '${viewModel.counter}',
                  );
                })
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: homeViewModel.incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
