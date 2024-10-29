import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/home/home.dart';
import '../../viewModels/home/home_view_model.dart';
import '../../viewModels/global/global_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalViewModel globalViewModel = GlobalViewModel();
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalViewModel = context.read<GlobalViewModel>();
      homeViewModel.callGetWeather(queryParams: {
        "latitude": "52.52",
        "longitude": "13.41",
        "hourly": "temperature_2m",
        "models": "cma_grapes_global",
      }, header: globalViewModel.plantHeaders);
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
            centerTitle: true,
          ),
          body: Center(
            child: Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                return FutureBuilder<HourlyWeather?>(
                  future: viewModel.weatherFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    log(viewModel.hourlyWeather.time!.length.toString());
                    return ListView.builder(
                      itemCount: viewModel.hourlyWeather.time!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(viewModel.hourlyWeather.time![index]),
                          subtitle: Text(viewModel
                              .hourlyWeather.temperature_2m![index]
                              .toString()),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
