import 'package:flutter/material.dart';

class SonucEkrani extends StatefulWidget {

  int dogruSayisi;

  SonucEkrani({required this.dogruSayisi});

  @override
  State<SonucEkrani> createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Sonuç Ekranı",style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.dogruSayisi} DOĞRU , ${5-widget.dogruSayisi} YANLIŞ",style: TextStyle(fontSize: 25,color: Colors.black54),),
            Text("%${((widget.dogruSayisi*100)/5).toInt()} BAŞARI",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);

                },
                child: Text("TEKRAR DENE",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
