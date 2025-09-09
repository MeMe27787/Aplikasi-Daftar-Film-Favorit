import 'package:flutter/material.dart';
import 'screens/home_screen.dart';


void main() {
runApp(const MyApp());
}


class MyApp extends StatelessWidget {
const MyApp({super.key});


@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Daftar Film Favorit',
debugShowCheckedModeBanner: false,
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
useMaterial3: true,
scaffoldBackgroundColor: const Color(0xFFF6F7FB),
appBarTheme: const AppBarTheme(centerTitle: true),
),
home: const HomeScreen(),
);
}
}