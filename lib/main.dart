import 'package:flutter/material.dart';
import 'ui/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Colors.orange,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 5.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            )
          ),
        scaffoldBackgroundColor: Colors.yellow,
        fontFamily: 'Comic Sans',
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.orange,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          )
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.orange,
        )
        ),
        home: const LoginPage(),
    );
  }
}
