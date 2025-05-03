import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigames_minecraft/app/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'Minecraft',
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 48, 136, 51),
              foregroundColor: Colors.white,
              elevation: 2,
            ),
            textTheme: const TextTheme(
              headlineSmall: TextStyle(
                  color: Color(0xFF263238), fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(color: Color(0xFF263238)),
              bodySmall: TextStyle(color: Color(0xFF263238)),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 48, 136, 51),
              foregroundColor: Colors.white,
            ),
            cardColor: const Color(0xFFFFFFFF),
            dividerColor: const Color(0xFFBDBDBD),
            useMaterial3: true,
          )),
    ),
  );
}
