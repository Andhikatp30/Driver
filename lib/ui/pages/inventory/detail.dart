import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DetailBarang extends StatefulWidget {
  final String kurirName; // Tambahkan parameter untuk kurirName
  final String idPengiriman;

  const DetailBarang(
      {super.key, required this.kurirName, required this.idPengiriman});

  @override
  // ignore: library_private_types_in_public_api
  _DetailBarangState createState() => _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  String _status = ''; // Status default
  Map<String, dynamic>? barangData; // Menyimpan data barang

  final List<String> _statusOptions = [
    'Dikirim',
    'Selesai',
    'Belum Selesai',
  ];

  @override
  void initState() {
    super.initState();
    fetchDetailBarang(); // Panggil fungsi untuk mengambil data barang
  }

  Future<void> fetchDetailBarang() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/api/detail_barang.php'), // URL API
        body: {
          'kurirName': widget.kurirName,
          'id_pengiriman': widget.idPengiriman,
        },
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            barangData = data['data']; // Simpan data barang
          });
        } else {
          // ignore: avoid_print
          print('Error: ${data['message']}');
        }
      } else {
        // ignore: avoid_print
        print('Failed to load detail data');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching detail data: $e');
    }
  }

  Future<void> updateStatusBarang(String statusBaru) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/api/update_status.php'),
        body: {
          'kurirName': widget.kurirName,
          'id_pengiriman': barangData!['id_pengiriman'],
          'status': statusBaru,
        },
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      // Log untuk memastikan data yang dikirim benar
      // ignore: avoid_print
      print(
          'Mengirim data: kurirName = ${widget.kurirName}, id_pengiriman = ${barangData!['id_pengiriman']}, status = $statusBaru');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _status = statusBaru;
          });
          // Kembali ke layar 'data.dart'
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        } else {
          // ignore: avoid_print
          print('Error: ${data['message']}');
        }
      } else {
        // ignore: avoid_print
        print('Failed to update status');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error updating status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Barang',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
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
            Navigator.of(context).pop(); // Kembali ke layar sebelumnya
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: barangData == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // Menampilkan loading jika data belum ada
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionTitle('Informasi Barang'),
                      const Divider(color: Colors.grey),
                      buildInfoRow(
                          'ID Pengiriman', barangData!['id_pengiriman']),
                      buildInfoRow('ID Barang', barangData!['id_barang']),
                      buildInfoRow('Nama Barang', barangData!['nama_barang']),
                      const SizedBox(height: 20),
                      buildSectionTitle('Detail Pengiriman'),
                      const Divider(color: Colors.grey),
                      buildInfoRow(
                          'Nama Instansi', barangData!['nama_instansi']),
                      buildInfoRow(
                          'Alamat Instansi', barangData!['alamat_instansi']),
                      buildInfoRow('Jenis Barang', barangData!['jenis_barang']),
                      buildEditableStatus(),
                      buildInfoRow(
                          'Tanggal Kirim', barangData!['tanggal_kirim']),
                      const SizedBox(height: 20),
                      buildSectionTitle('Foto Barang'),
                      const Divider(color: Colors.grey),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: barangData!['foto_barang'] != null
                            ? Image.network(
                                barangData!['foto_barang'],
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Icon(Icons.image,
                                    color: Colors.grey, size: 50),
                              ),
                      ),
                      const SizedBox(
                          height: 20), // Tambahkan jarak antara foto dan tombol
                      ElevatedButton(
                        onPressed: () {
                          updateStatusBarang(
                              _status); // Memanggil fungsi untuk update status
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Warna tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Simpan',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildEditableStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Status',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              value: _statusOptions.contains(_status) ? _status : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: _statusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.poppins(fontSize: 14)),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _status = newValue; // Simpan status baru dalam state
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
