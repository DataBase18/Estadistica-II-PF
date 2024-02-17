import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/screens/physical/conversion/ui/ConversionScreen.dart';
import 'package:fisicapf/screens/screens.dart';
import 'package:fisicapf/themes/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightMainColorScheme,
      ),
      routes: {
        GlobalConstants.homeScreenPath: (_) => HomeScreen(),
        GlobalConstants.conversionsScreen: (_) => ConversionScreen()
      },
      initialRoute: GlobalConstants.homeScreenPath,
    );
  }
}

