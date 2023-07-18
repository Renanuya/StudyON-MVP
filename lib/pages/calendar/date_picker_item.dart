import 'package:flutter/material.dart';

class DatePickerItem extends StatelessWidget {
  const DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 33, 33, 33)
              : const Color(0xFFE7E7E6),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
