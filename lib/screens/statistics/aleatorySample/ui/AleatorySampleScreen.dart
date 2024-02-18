
import 'package:fisicapf/screens/statistics/aleatorySample/data/AleatorySampleConstants.dart';
import 'package:flutter/material.dart';

class AleatorySampleScreen extends StatefulWidget {
  const AleatorySampleScreen({super.key});

  @override
  State<AleatorySampleScreen> createState() => _AleatorySampleScreenState();
}

class _AleatorySampleScreenState extends State<AleatorySampleScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom:  TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.format_list_numbered),
                      Text(AleatorySampleConstants.tabSequenceIntervalTitle),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.input),
                      Text(AleatorySampleConstants.tabManualDataTitle),
                    ],
                  ),
                )
              ],
            ),
            title: Center(child: Text(AleatorySampleConstants.title)),
          ),
          body: const TabBarView(
            children: [
              Text("Screen 1"),
              Text("Screen 2"),
            ],
          )
        ),
      ),
    );
  }
}
