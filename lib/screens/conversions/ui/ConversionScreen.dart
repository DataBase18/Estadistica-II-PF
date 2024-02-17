

import 'package:fisicapf/screens/conversions/data/ConversionConstants.dart';
import 'package:fisicapf/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width =MediaQuery.of(context).size.width;

    return Column(
      children: [
        Center(child: TitleText(text: ConversionConstants.homeTitle, fontSize: 25,)),
        SizedBox(height: height*0.01,),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: width*0.035),
            itemCount: ConversionConstants.menus.length,
            itemBuilder: (context, index){
              return MenuItemCard(
                item: ConversionConstants.menus.elementAt(index),
              );
            },
          ),
        )
      ],
    );
  }
}
