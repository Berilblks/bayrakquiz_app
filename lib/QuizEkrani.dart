import 'dart:collection';

import 'package:bayrakquiz_app/Bayraklar.dart';
import 'package:bayrakquiz_app/Bayraklardao.dart';
import 'package:bayrakquiz_app/SonucEkrani.dart';
import 'package:flutter/material.dart';

class Quizekrani extends StatefulWidget {
  const Quizekrani({super.key});

  @override
  State<Quizekrani> createState() => _QuizekraniState();
}

class _QuizekraniState extends State<Quizekrani> {

  var sorular = <Bayraklar>[];
  var yanlisSecenekler = <Bayraklar>[];
  late Bayraklar dogruSoru;
  var tumSecenekler = HashSet<Bayraklar>();

  int soruSayac = 0;
  int dogruSayac = 0;
  int yanlisSayac = 0;

  String bayrakResimAdi = "placeholder.png";
  String buttonAyazi = "";
  String buttonByazi = "";
  String buttonCyazi = "";
  String buttonDyazi = "";

  @override
  void initState() {
    super.initState();
    
    sorulariAl();
  }

  Future<void> sorulariAl() async {
    sorular = await Bayraklardao().rastgele5Getir();
    sorulariYukle();
    
  }
  Future<void> sorulariYukle() async {
    dogruSoru = sorular[soruSayac];
    
    bayrakResimAdi = dogruSoru.bayrak_resim;
    
    yanlisSecenekler = await Bayraklardao().rastgele3YanlisGetir(dogruSoru.bayrak_id);

    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisSecenekler[0]);
    tumSecenekler.add(yanlisSecenekler[1]);
    tumSecenekler.add(yanlisSecenekler[2]);

    buttonAyazi = tumSecenekler.elementAt(0).bayrak_ad;
    buttonByazi = tumSecenekler.elementAt(1).bayrak_ad;
    buttonCyazi = tumSecenekler.elementAt(2).bayrak_ad;
    buttonDyazi = tumSecenekler.elementAt(3).bayrak_ad;

    setState(() {
    });
  }

  void soruSayacKontrol(){
    soruSayac = soruSayac + 1;

    if(soruSayac != 5){
      sorulariYukle();
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SonucEkrani(dogruSayisi: dogruSayac)));
    }
  }

  void dogruKontrol(String buttonYazi){
    if(dogruSoru.bayrak_ad == buttonYazi){
      dogruSayac = dogruSayac + 1;
    }
    else{
      yanlisSayac = yanlisSayac + 1;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Quiz Ekranı",style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Doğru : $dogruSayac",style: TextStyle(fontSize: 18),),
                Text("Yanlış : $yanlisSayac",style: TextStyle(fontSize: 18),),
              ],
            ),
            soruSayac != 5 ? Text("${soruSayac+1}. SORU",style: TextStyle(fontSize: 30),) : Text("5. SORU",style: TextStyle(fontSize: 30),),
            Image.asset("imagesBayrak/$bayrakResimAdi"),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogruKontrol(buttonAyazi);
                  soruSayacKontrol();
                },
                child: Text(buttonAyazi,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogruKontrol(buttonByazi);
                  soruSayacKontrol();
                },
                child: Text(buttonByazi,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogruKontrol(buttonCyazi);
                  soruSayacKontrol();
                },
                child: Text(buttonCyazi,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogruKontrol(buttonDyazi);
                  soruSayacKontrol();
                },
                child: Text(buttonDyazi,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
