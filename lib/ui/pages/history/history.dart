import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:driver/ui/pages/home/home.dart';
import 'package:driver/ui/pages/history/detail.dart';

class History extends StatefulWidget {
  final String userName; // Parameter untuk menyimpan nama pengguna

  const History(
      {super.key,
      required this.userName}); // Menjadikan userName sebagai parameter wajib

  @override
  // ignore: library_private_types_in_public_api
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> historyList = []; // Menyimpan data history

  @override
  void initState() {
    super.initState();
    fetchHistoryData(); // Memanggil data saat inisialisasi
  }

  // Fungsi untuk mengambil data history dari API
  Future<void> fetchHistoryData() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/api/history.php'), // Ganti dengan URL API Anda
        body: {'kurirName': widget.userName}, // Menggunakan widget.userName
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      // Tambahkan debug print untuk melihat respons
      // ignore: avoid_print
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            historyList = List<Map<String, dynamic>>.from(data['data']);
          });
        } else {
          // ignore: avoid_print
          print('Error: ${data['message']}');
        }
      } else {
        // ignore: avoid_print
        print('Failed to load history data');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching history data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
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
            final homeState = context.findAncestorStateOfType<HomeState>();
            homeState?.onItemTapped(0);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            return buildCard(historyList[index], context);
          },
        ),
      ),
    );
  }

  // Fungsi untuk membuat kartu tampilan data history
  Widget buildCard(Map<String, dynamic> history, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika card ditekan
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.blueAccent, width: 2),
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
                    'ID Transaksi: ${history['id_transaksi']}',
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
                    'Nama Barang: ${history['nama_barang']}',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailRiwayat(
                          pengiriman: history), // Hapus 'const' di sini
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
