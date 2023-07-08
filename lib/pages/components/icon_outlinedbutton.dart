import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconOutlinedButton extends StatelessWidget {
  const IconOutlinedButton(
      {super.key, this.onPressed, required this.text, required this.icon});

  final void Function()? onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        /* backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 238, 238, 238),
        ),
        surfaceTintColor: MaterialStateProperty.all<Color>(
          const Color(0x00F7F7F5),
        ),*/
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            //  color: Color(0xffE0E0DE), //Etraftaki çizgi rengi
            width: 1.5,
          ),
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, // İkonu burada değiştirebilirsiniz
            // color: const Color(0xff37352F), // İkonun rengi
          ),
          const SizedBox(
              width: 8), // İkon ile metin arasında bir boşluk ekleyebilirsiniz
          Text(
            text,
            style: GoogleFonts.inter(
              //  color: const Color(0xff37352F), // Fontun rengi
              fontSize: mHeight * 0.023,
            ),
          ),
        ],
      ),
    );
  }
}