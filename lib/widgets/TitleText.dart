
import 'package:flutter/cupertino.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text, this.fontSize=35, this.bold=false,  this.maxLines});
  final String text;
  final double fontSize;
  final bool bold;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold?FontWeight.bold:FontWeight.normal
      ),
    );
  }
}
