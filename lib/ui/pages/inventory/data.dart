import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:driver/ui/pages/home/home.dart';
import 'package:driver/ui/pages/inventory/detail.dart';

class DataPengiriman extends StatefulWidget {
  final String userName; // Tambahkan parameter userName

  const DataPengiriman(
      {super.key, required this.userName}); // Make userName required

  @override
  // ignore: library_private_types_in_public_api
  _DataPengirimanState createState() => _DataPengirimanState();
}

class _DataPengirimanState extends State<DataPengiriman> {
  List<Map<String, dynamic>> pengirimanList = [];

  @override
  void initState() {
    super.initState();
    fetchPengirimanData();
  }

  Future<void> fetchPengirimanData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/api/pengiriman.php'),
        body: {'kurirName': widget.userName}, // Gunakan widget.userName
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            pengirimanList = List<Map<String, dynamic>>.from(data['data']);
          });
        } else {
          // ignore: avoid_print
          print('Error: ${data['message']}');
        }
      } else {
        // ignore: avoid_print
        print('Failed to load pengiriman data');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching pengiriman data: $e');
    }
  }

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
            final homeState = context.findAncestorStateOfType<HomeState>();
            homeState?.onItemTapped(0);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: pengirimanList.length,
          itemBuilder: (context, index) {
            return buildCard(pengirimanList[index], context);
          },
        ),
      ),
    );
  }

  Widget buildCard(Map<String, dynamic> pengiriman, BuildContext context) {
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
                    'ID Pengiriman: ${pengiriman['id_pengiriman']}',
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
                    'Nama Barang: ${pengiriman['nama_barang']}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Text(
                    'ID Barang: ${pengiriman['id_barang']}',
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
                        builder: (context) => DetailBarang(
                          kurirName: widget.userName,
                          idPengiriman: pengiriman[
                              'id_pengiriman'], // Teruskan userName ke detail
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
