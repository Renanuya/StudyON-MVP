import 'package:flutter/material.dart';

class ColorButton extends StatefulWidget {
  final Color color;

  final Function onPressed;

  const ColorButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ColorButtonState createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onPressed(isSelected);
      },
      child: Stack(
        children: [
          Container(
            width: 60,
            height: 40,
            decoration: ShapeDecoration(
              color: widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (isSelected)
            const Align(
              child: Icon(
                Icons.check_circle,
                color: Colors.black,
                size: 16,
              ),
            )
        ],
      ),
    );
  }
}
