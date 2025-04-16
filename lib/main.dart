import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc_observer.dart';
import 'package:market/features/employers/presentation/cubit/cubit.dart';
import 'package:market/features/employers/presentation/screens/log_in.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/purchase/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/global/database.dart';
import 'package:market/global/home_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'global/global.dart';


Database? databaseFile;

Future<void> main(List<String> args) async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  await createDatabase();
  // await getData();

  runApp( MyApp(isSecondScreen: args.isNotEmpty,admin:args.isEmpty?null:args[1]=='admin'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isSecondScreen, required this.admin});
  final bool isSecondScreen;
  final bool? admin;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    isAdmin=admin??isAdmin;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SalesCubit(),
        ),
        BlocProvider(
          create: (context) => EmployersCubit()..getUsers(),
        ),
        BlocProvider(
          create: (context) => PurchasesCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isSecondScreen? const HomeScreen(): const LogIn(),
      ),
    );
  }
}
