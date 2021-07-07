import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onPressed;

  CustomTextButton({
    required this.title,
    required this.onPressed,
    this.isActive = false,
  }) : assert(title.isNotEmpty);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  final activeColor = Colors.blue;
  final notActiveColor = Colors.grey[700];

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.isActive ? activeColor : notActiveColor,
          ),
        ),
      ),
      onPressed: () {
        widget.onPressed();
      },
    );
  }
}
