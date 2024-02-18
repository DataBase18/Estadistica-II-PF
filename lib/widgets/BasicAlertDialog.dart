
import 'package:flutter/material.dart';

class BasicAlertDialog extends StatelessWidget {
  const BasicAlertDialog({super.key, this.title, required this.content, this.onClose, this.onCloseTextButton});
  final String? title;
  final String content;
  final Function()? onClose;
  final String? onCloseTextButton;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Aviso"),
      content:  Text(content),
      actions: [
        TextButton(onPressed: onClose ?? ()=>Navigator.pop(context), child: Text(onCloseTextButton ?? "Aceptar"))
      ],
    );
  }
}
