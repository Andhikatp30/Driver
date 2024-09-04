// ignore_for_file: sort_child_properties_last
import 'package:driver/ui/pages/loginsign/login.dart';
import 'package:driver/ui/pages/loginsign/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenFour extends StatelessWidget {
  const SplashScreenFour({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                //gambar sebagai gambar tampilan disetiap landing page(Sebagai BG)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Driver Corner',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(
                  "assets/images/splashtwo.png",
                  width: MediaQuery.of(context).size.width,
                  height: 325,
                ),

                //pembuatan container untuk isi konten
                ListView(
                  children: [
                    const SizedBox(
                      height: 325,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        ),
                        color: Colors.teal,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 45),
                        child: Column(
                          children: [
                            Text(
                              "Friendly",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text(
                                "Antarmuka yang ramah pengguna, memastikan pengemudi dapat menavigasi dan menggunakan fitur dengan mudah.",
                                maxLines: 7,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  elevation: 8,
                                  shadowColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(45)),
                              child: Text(
                                "Masuk",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Apakah kamu sudah memiliki akun ?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Sign()));
                                  },
                                  child: Text(
                                    "Daftar",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 208, 0, 1),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
