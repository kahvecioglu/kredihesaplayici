import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController aracFiyatiController = TextEditingController();
  TextEditingController pesinatController = TextEditingController();
  TextEditingController faizOraniController = TextEditingController();
  String krediSuresi = '1';
  double toplamFaiz = 0.0;
  double kalanborc = 0.0;
  double aylikTaksit = 0.0;
  void krediHesapla() {
    // Araç fiyatı ve peşinat
    final double amount = double.parse(aracFiyatiController.text) -
        double.parse(pesinatController.text);
    final double faizOrani =
        double.parse(faizOraniController.text) / 100; // Faiz oranı yüzdesi
    final int krediSuresi = int.parse(this.krediSuresi); // Yıllık kredi süresi

    // Toplam faiz hesaplama (basit faiz formülü)
    final double toplamFaiz = amount *
        faizOrani *
        krediSuresi; // Anapara * faiz oranı * kredi süresi (yıl)

    // Toplam geri ödeme hesaplama
    final double toplamGeriOdeme = amount + toplamFaiz; // Anapara + toplam faiz

    // Aylık taksit hesaplama: toplam geri ödeme / toplam ay sayısı
    final double aylikTaksit = toplamGeriOdeme / (krediSuresi * 12);

    setState(() {
      this.toplamFaiz = toplamFaiz; // Değişkeni güncelle
      this.aylikTaksit = aylikTaksit; // Değişkeni güncelle
      this.kalanborc = toplamGeriOdeme; // Kalan borç toplam geri ödeme
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 14, 3, 56),
        elevation: 5,
        title: Text(
          'Kredi Hesaplayıcı',
          style: GoogleFonts.robotoMono(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 14, 3, 56),
          child: Column(
            children: [
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueGrey[900]!, Colors.blueGrey[700]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.directions_car,
                          size: 50,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.home,
                          size: 50,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.shopping_cart_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.travel_explore,
                          size: 50,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputForm(
                      title: 'Çekilecek Miktar',
                      hintText: 'Örneğin 90000',
                      controller: aracFiyatiController,
                    ),
                    inputForm(
                      title: 'Peşinat',
                      hintText: 'Örneğin 9000',
                      controller: pesinatController,
                    ),
                    inputForm(
                      title: 'Faiz Oranı (%)',
                      hintText: 'Örneğin 3.5',
                      controller: faizOraniController,
                    ),
                    Text(
                      'Kredi Süresi (Yıl)',
                      style: GoogleFonts.robotoMono(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Kredi süresi butonları
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        krediSuresiButonu('1'),
                        krediSuresiButonu('2'),
                        krediSuresiButonu('3'),
                        krediSuresiButonu('4'),
                        krediSuresiButonu('5'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        krediSuresiButonu('6'),
                        krediSuresiButonu('7'),
                        krediSuresiButonu('8'),
                        krediSuresiButonu('9'),
                      ],
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        if (pesinatController.text.isNotEmpty &&
                            faizOraniController.text.isNotEmpty &&
                            aracFiyatiController.text.isNotEmpty) {
                          krediHesapla();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: false,
                            backgroundColor: Colors.blueGrey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Sonuçlar',
                                      style: GoogleFonts.robotoMono(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15),
                                    sonuclar(
                                        title: 'Toplam Faiz',
                                        amount: toplamFaiz),
                                    sonuclar(
                                        title: 'Kalan Borç', amount: kalanborc),
                                    sonuclar(
                                        title: 'Aylık Taksit',
                                        amount: aylikTaksit),
                                    SizedBox(height: 30),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[700],
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Yeniden Hesapla',
                                            style: GoogleFonts.robotoMono(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: Text(
                              "Hiçbir alan boş bırakılamaz. Lütfen gerekli tüm alanları doldurun.",
                              style: GoogleFonts.openSans(color: Colors.white),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 50, 100, 126),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[700],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Hesapla',
                            style: GoogleFonts.robotoMono(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sonuclar({required String title, required double amount}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Text(
          '₺' + amount.toStringAsFixed(2),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget krediSuresiButonu(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          krediSuresi = title;
        });
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: title == krediSuresi
              ? Border.all(color: Colors.amber, width: 2)
              : null,
          color: Colors.blueGrey[600],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget inputForm(
      {required String title,
      required String hintText,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.robotoMono(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.blueGrey[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
