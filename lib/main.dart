import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/home/cubit/get_users_cubit.dart';
import 'package:task_app/repository/api_reposiitory.dart';

import 'home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp(
    apiService: ApiRepository(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.apiService}) : super(key: key);

  final ApiRepository apiService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetUsersCubit>(
      lazy: false,
      create: (context) => GetUsersCubit(apiService)..fetchUsers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UsersList(),
      ),
    );
  }
}
