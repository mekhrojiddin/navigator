import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uy_ishi_map/bloc/location_bloc.dart';
import 'package:uy_ishi_map/location_page.dart';
import 'package:uy_ishi_map/permission.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await permission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LocationPage(),
      ),
    );
  }
}
