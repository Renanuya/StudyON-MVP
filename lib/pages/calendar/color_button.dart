import 'package:flutter/material.dart';
import 'package:thinktank/constants.dart';

class ColorSelector extends StatefulWidget {
  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color? selectedColor;

  void selectColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    return Container(
      height: mHeight * 0.1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ColorButton(
            color: AppColors.kColorRed,
            isSelected: selectedColor == AppColors.kColorRed,
            onPressed: selectColor,
          ),
          ColorButton(
            color: AppColors.kColorYellow,
            isSelected: selectedColor == AppColors.kColorYellow,
            onPressed: selectColor,
          ),
          ColorButton(
            color: AppColors.kColorBlue,
            isSelected: selectedColor == AppColors.kColorBlue,
            onPressed: selectColor,
          ),
          ColorButton(
            color: AppColors.kColorGreen,
            isSelected: selectedColor == AppColors.kColorGreen,
            onPressed: selectColor,
          ),
        ],
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final Function(Color) onPressed;

  const ColorButton({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onPressed(color);
        }
      },
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          border: Border.all(color: AppColors.kColorBlack),
        ),
        child: Stack(
          children: [
            if (isSelected)
              const Positioned(
                bottom: 2,
                right: 2,
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.kColorBlack,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
