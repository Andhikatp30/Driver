import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Profil Perusahaan',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo perusahaan
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logoslog.png', // Ganti dengan path logo perusahaan Anda
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nama Perusahaan dan Deskripsi
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sinergi Lintas Global',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah Sinergi Lintas Global atau S-Log adalah...',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
