import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailRiwayat extends StatelessWidget {
  const DetailRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              'Detail Riwayat',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Mengubah posisi bayangan
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildStatusRow(),
                const SizedBox(height: 20),
                buildSectionTitle('Informasi Barang'),
                const Divider(color: Colors.grey),
                buildInfoRow('ID Pengiriman', '12345678'),
                buildInfoRow('ID Barang', '12345678'),
                buildInfoRow('Nama Barang', 'Alat Kesehatan'),
                const SizedBox(height: 20),
                buildSectionTitle('Detail Pengiriman'),
                const Divider(color: Colors.grey),
                buildInfoRow(
                    'Nama Instansi', 'Badan Kesehatan Daerah Jakarta Barat'),
                buildInfoRow('Penerima', 'Rumah Sakit XYZ Jakarta Utara'),
                buildInfoRow('Jenis Barang', 'Sedang'),
                // buildEditableStatus(),
                buildInfoRow('Status', 'Selesai'),
                buildInfoRow('Tanggal Kirim', '2024-09-19'),
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
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.grey, size: 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStatusRow() {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 30),
        const SizedBox(width: 10),
        Text(
          'Berhasil Dikirim',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  // Widget buildEditableStatus() {
  //   String _status = 'Dalam Perjalanan';
  //   List<String> _statusOptions = [
  //     'Dalam Perjalanan',
  //     'Sudah Sampai',
  //     'Dibatalkan'
  //   ];

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Text(
  //             'Status',
  //             style: GoogleFonts.poppins(
  //               textStyle: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w600,
  //                 color: Colors.black87,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 3,
  //           child: DropdownButtonFormField<String>(
  //             value: _status,
  //             decoration: const InputDecoration(
  //               border: OutlineInputBorder(),
  //             ),
  //             items: _statusOptions.map((String value) {
  //               return DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value, style: GoogleFonts.poppins(fontSize: 14)),
  //               );
  //             }).toList(),
  //             onChanged: (newValue) {
  //               // Logika untuk menangani perubahan status
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
