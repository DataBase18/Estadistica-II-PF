
import 'package:fisicapf/screens/physical/conversion/data/TextConstantsConversion.dart';
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
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded, size: 35,)),
            SizedBox(height: height*0.01 ,),
            Center(child: TitleText(text: TextConstantsConversion.conversionsTitle)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.05),
              child: Column(
                children: [
                  Text(TextConstantsConversion.unitLabel),
                  DropdownButton(
                    items: [],
                    onChanged: (value){

                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
