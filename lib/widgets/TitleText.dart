
import 'package:flutter/cupertino.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text, this.fontSize=35, this.bold=false,  this.maxLines, this.align});
  final String text;
  final double fontSize;
  final bool bold;
  final int? maxLines;
  final TextAlign? align;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold?FontWeight.bold:FontWeight.normal
      ),
    );
  }
}
