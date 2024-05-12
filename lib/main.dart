import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/screens/physical/conversion/ui/ConversionScreen.dart';
import 'package:fisicapf/screens/screens.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCScreen.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleScreen.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/ui/IntervalEstimationScreen.dart';
import 'package:fisicapf/services/services.dart';
import 'package:fisicapf/themes/themes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLLiteService.initDataBase();
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
        GlobalConstants.conversionsScreen: (_) => ConversionScreen(),
        GlobalConstants.aleatorySampleScreen: (_) => AleatorySampleScreen(),
        GlobalConstants.sizeSampleCalcScreen: (_) => SizeSampleCalcScreen(),
        GlobalConstants.intervalEstimationScreen: (_) => IntervalEstimationScreen(),
        GlobalConstants.inferenceAboutSampleScreen: (_) => InferenceAboutSampleScreen(),
        GlobalConstants.mmcScreen: (_) => MMCScreen()
      },
      initialRoute: GlobalConstants.homeScreenPath,
    );
  }
}

