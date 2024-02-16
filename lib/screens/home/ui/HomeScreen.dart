

import 'package:fisicapf/screens/home/data/ConversionConstants.dart';
import 'package:fisicapf/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TitleText(text: ConversionConstants.homeTitle, fontSize: 22,),
            SizedBox(height: height*0.01,),

          ],
        ),
      ),
    );
  }

}
