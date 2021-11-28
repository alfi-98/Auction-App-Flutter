import 'package:flutter/material.dart';

class OptionBar extends StatelessWidget {
  final IconData icon;
  final String text;
  final double sizeFont;
  final void Function()? onTap;
  const OptionBar(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onTap,
      required this.sizeFont});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(
            width: 20,
          ),
          Text(text, style: TextStyle(color: Colors.white, fontSize: sizeFont))
        ],
      ),
    );
  }
}
