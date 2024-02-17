

import 'dart:ffi';

import 'package:fisicapf/screens/physical/home/data/PhysicalConstants.dart';
import 'package:fisicapf/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PhysicalScreen extends StatefulWidget {
  const PhysicalScreen({super.key});

  @override
  State<PhysicalScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<PhysicalScreen> {

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width =MediaQuery.of(context).size.width;

    return Column(
      children: [
        Center(child: TitleText(text: PhysicalConstants.homeTitle, fontSize: 25,)),
        SizedBox(height: height*0.01,),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: width*0.035),
            itemCount: PhysicalConstants.menus.length,
            itemBuilder: (context, index){
              return MenuItemCard(
                item: PhysicalConstants.menus.elementAt(index),
                onTab: (){
                  Navigator.pushNamed(context, PhysicalConstants.menus.elementAt(index).screenPath! );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
