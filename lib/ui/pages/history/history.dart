import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:driver/ui/pages/home/home.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            final homeState = context.findAncestorStateOfType<HomeState>();
            homeState?.onItemTapped(0); // Navigate back to the home tab
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 4, // Jumlah item dalam list
          itemBuilder: (context, index) {
            return buildCard(index + 1, context); // Ensure buildCard is defined
          },
        ),
      ),
    );
  }

  Widget buildCard(int itemNumber, BuildContext context) {
    return Card(
      elevation: 3,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      //   side: itemNumber == 1 // Jika item pertama, tambahkan border biru
      //       ? const BorderSide(color: Colors.blue, width: 2)
      //       : BorderSide.none,
      // ),
      color: const Color(0xFFB2EBF2),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID barang : ${itemNumber == 1 ? '12345678' : 'xxxxxxxxxxxx'}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Nama barang : ${itemNumber == 1 ? 'Alat Kesehatan' : 'xxxxxxxxxxxx'}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.blue),
              onPressed: () {
                // Aksi ketika tombol info ditekan
              },
            ),
          ],
        ),
      ),
    );
  }
}
