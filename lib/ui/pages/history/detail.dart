import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailRiwayat extends StatelessWidget {
  final Map<String, dynamic> pengiriman;

  const DetailRiwayat({super.key, required this.pengiriman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildStatusRow(pengiriman['status_pengiriman']),
                  const SizedBox(height: 20),
                  buildSectionTitle('Informasi Barang'),
                  const Divider(color: Colors.grey),
                  buildInfoRow('ID Pengiriman', pengiriman['id_pengiriman']),
                  buildInfoRow('ID Barang', pengiriman['id_barang']),
                  buildInfoRow('Nama Barang', pengiriman['nama_barang']),
                  const SizedBox(height: 20),
                  buildSectionTitle('Detail Pengiriman'),
                  const Divider(color: Colors.grey),
                  buildInfoRow('Nama Instansi', pengiriman['nama_instansi']),
                  buildInfoRow(
                      'Alamat Instansi', pengiriman['alamat_instansi']),
                  buildInfoRow('Jenis Barang', pengiriman['jenis_barang']),
                  buildInfoRow('Status', pengiriman['status_pengiriman']),
                  buildInfoRow('Tanggal Kirim', pengiriman['tanggal_kirim']),
                  const SizedBox(height: 20),
                  buildSectionTitle('Foto Barang'),
                  const Divider(color: Colors.grey),
                  buildFotoBarang(pengiriman['foto_barang']),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Detail Riwayat',
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
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget buildStatusRow(String? status) {
    Color iconColor = Colors.grey;
    String statusText = 'Status Tidak Diketahui';

    if (status == 'Selesai') {
      iconColor = Colors.green;
      statusText = 'Berhasil Dikirim';
    } else if (status == 'Dalam Pengiriman') {
      iconColor = Colors.orange;
      statusText = 'Dalam Pengiriman';
    } else if (status == 'Dibatalkan') {
      iconColor = Colors.red;
      statusText = 'Pengiriman Dibatalkan';
    }

    return Row(
      children: [
        Icon(Icons.check_circle, color: iconColor, size: 50),
        const SizedBox(width: 10),
        Text(
          statusText,
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

  Widget buildInfoRow(String title, String? value) {
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
              value ?? 'Tidak Tersedia',
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
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
    );
  }

  Widget buildFotoBarang(String? fotoUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: fotoUrl != null && fotoUrl.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                fotoUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child:
                        Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  );
                },
              ),
            )
          : const Center(
              child: Icon(
                Icons.image,
                color: Colors.grey,
                size: 50,
              ),
            ),
    );
  }
}
