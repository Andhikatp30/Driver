import 'package:driver/ui/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPengiriman extends StatelessWidget {
  const DataPengiriman({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Pengiriman',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            // Navigator.of(context).pop(); // Navigate back to the previous screen
            final homeState = context.findAncestorStateOfType<HomeState>();
            homeState?.onItemTapped(0);
          },
        ),
      ),
      backgroundColor: Colors.grey[100], // Soft grey background for contrast
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 4, // Jumlah item dalam list
          itemBuilder: (context, index) {
            return buildCard(index + 1, context);
          },
        ),
      ),
    );
  }

  Widget buildCard(int itemNumber, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika card ditekan
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: itemNumber == 1
              ? const BorderSide(color: Colors.blueAccent, width: 2)
              : BorderSide.none,
        ),
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID Barang: ${itemNumber == 1 ? '12345678' : 'xxxxxxxxxxxx'}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Nama Barang: ${itemNumber == 1 ? 'Alat Kesehatan' : 'xxxxxxxxxxxx'}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.info_outline,
                    color: Colors.blueAccent, size: 30),
                onPressed: () {
                  // Aksi ketika tombol info ditekan
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
