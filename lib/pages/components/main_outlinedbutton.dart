import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainOutlinedButton extends StatelessWidget {
  const MainOutlinedButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.textSize,
  });

  final void Function()? onPressed;

  final String text;
  final double textSize;

// 0.023
  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        /*backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 238, 238, 238),
        ),
        surfaceTintColor: MaterialStateProperty.all<Color>(
          const Color(0x00F7F7F5),
        ),*/
        /* side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            //   color: Color(0xffE0E0DE), //Etraftaki çizgi rengi
            width: 1.5,
          ),
        ),*/
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(mWidth * 0.81, mHeight * 0.075),
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          const Color(0xffC1D8C1), //Basılınca gerçekleşen animasyon rengi
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          //  color: const Color(0xff37352F), //Fontun rengi
          fontWeight: FontWeight.normal,
          fontSize: mHeight * textSize,
        ),
      ),
    );
  }
}