import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeynmanPage extends StatelessWidget {
  const FeynmanPage({super.key});

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Study',
            style: GoogleFonts.pacifico(
              fontSize: mHeight * 0.04,
              color: const Color(0xFF37352f),
            ),
            children: const [
              TextSpan(
                text: 'On',
                style: TextStyle(
                  color: Color.fromARGB(255, 101, 191, 107),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Feynman Çalışma Tekniği',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Feynman ders çalışma tekniği, ünlü fizikçi Richard Feynman tarafından geliştirilmiş bir öğrenme yöntemidir. Bu teknik, karmaşık konuları basit ve anlaşılır bir şekilde öğrenmeyi ve öğrendiklerinizi başkalarına anlatmayı vurgular. Feynman ders çalışma tekniği, bilgileri derinlemesine anlamak ve hatırlamak için etkili bir yol sunar.\n\nFeynman ders çalışma tekniği aşağıdaki adımlardan oluşur:\n\n1- Konuyu Seçin: İlk adım, öğrenmek istediğiniz konuyu belirlemektir. Bu bir matematik problemi, bilimsel bir teori veya herhangi bir ders konusu olabilir. Seçtiğiniz konuyu iyice anlamak için o konu hakkında bilgi edinmeniz gerekmektedir.\n\n2- Bilgi Edinin: Seçtiğiniz konuyla ilgili kaynaklardan bilgi edinin. Ders kitaplarını, makaleleri, videoları veya herhangi bir kaynağı kullanarak konuyla ilgili temel bilgileri öğrenin. Bu adımda, konuyu anlamanıza yardımcı olacak notlar alın.\n\n3- asit Bir Dil Kullanın: Feynman ders çalışma tekniği, konuyu anlamak için basit bir dil kullanmayı vurgular. Öğrendiğiniz konuyu kendi kelimelerinizle ifade edin. Bilgiyi mümkün olduğunca basitleştirerek anlatmaya çalışın. Karmaşık kavramları ve terimleri sadeleştirin. Bu, konuyu daha iyi anlamanıza ve hatırlamanıza yardımcı olur.\n\n4- İfade Edin: Öğrendiklerinizi başkalarına anlatmak, Feynman ders çalışma tekniğinin önemli bir adımıdır. Seçtiğiniz bir kişiye veya hayali bir öğrenciye konuyu açıklamaya çalışın. Konuyu anlatırken kendi kelimelerinizi kullanın ve konunun temel noktalarını vurgulayın. Eğer başka birine anlatırken takıldığınız noktalar varsa, o noktaları tekrar gözden geçirin ve anlamaya çalışın.\n\n5- Eksiklikleri ve Yanlış Anlamaları Tespit Edin: Konuyu başkalarına anlattıktan sonra, eksiklikleri ve yanlış anlamaları tespit etmek için geri bildirim alın. İfadeniz sırasında anlamadığınız veya tam olarak açıklayamadığınız noktalar varsa, bu noktaları yeniden çalışın. Konuyu daha iyi anlamak için ek kaynaklara başvurabilir veya öğretim materyallerini inceleyebilirsiniz.\n\n6- Tekrarlayın: Feynman ders çalışma tekniği, bilgileri tekrar etmeyi vurgular. Öğrendiğiniz konuyu düzenli aralıklarla tekrarlayın. Tekrarlar, bilgilerinizi güçlendirmenize ve uzun vadeli bellekte tutmanıza yardımcı olur.\n\nFeynman ders çalışma tekniği, karmaşık konuları anlamak ve hatırlamak için etkili bir yöntemdir. Konuları basit bir dille ifade etmek ve başkalarına anlatmak, konuları daha derinlemesine anlamanıza yardımcı olur. Ancak, herkesin öğrenme tarzı farklı olduğu için, Feynman tekniğinin herkes için uygun olmayabileceğini unutmayın. Kendi öğrenme tarzınıza uygun yöntemleri deneyerek, en etkili çalışma yöntemini bulmanız önemlidir.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
