import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailBarang extends StatefulWidget {
  final String kurirName;
  final String idPengiriman;
  final String fotoBarangUrl;

  const DetailBarang({
    Key? key,
    required this.kurirName,
    required this.idPengiriman,
    required this.fotoBarangUrl,
  }) : super(key: key);

  @override
  _DetailBarangState createState() => _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  String _status = 'Akan Dikirim';
  Map<String, dynamic>? barangData;

  final List<String> _statusOptions = [
    'Dikirim',
    'Selesai',
    'Belum Selesai',
  ];

  @override
  void initState() {
    super.initState();
    fetchDetailBarang();
  }

  Future<void> fetchDetailBarang() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/api/detail_barang.php'),
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
            barangData = data['data'];
          });
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print('Failed to load detail data');
      }
    } catch (e) {
      print('Error fetching detail data: $e');
    }
  }

  Future<void> updateStatusBarang(String statusBaru) async {
    if (_status == barangData!['status']) {
      _showPopupNotif(
        'Info',
        'Status sudah diperbarui, tidak ada perubahan lebih lanjut.',
        isSuccess: true,
        shouldPopOnClose: false,
      );
      return;
    }

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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _status = statusBaru;
          });
          _showPopupNotif(
            'Berhasil',
            'Status berhasil diperbarui menjadi "$statusBaru".',
            isSuccess: true,
            shouldPopOnClose: true,
          );
        } else {
          _showPopupNotif(
            'Gagal',
            'Gagal memperbarui status: ${data['message']}',
            isSuccess: false,
          );
        }
      } else {
        _showPopupNotif('Gagal', 'Gagal memperbarui status.', isSuccess: false);
      }
    } catch (e) {
      _showPopupNotif('Error', 'Terjadi kesalahan: $e', isSuccess: false);
    }
  }

  void _showPopupNotif(String title, String message,
      {bool isSuccess = true, bool shouldPopOnClose = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(maxWidth: 350),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: isSuccess ? Colors.green[50] : Colors.red[50],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                  color: isSuccess ? Colors.green : Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSuccess ? Colors.green[800] : Colors.red[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? Colors.green : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (shouldPopOnClose) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> openGoogleMaps(String address) async {
    // Construct the Google Maps URL
    final Uri mapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );

    // Try launching the URL
    if (await canLaunchUrl(mapsUrl)) {
      await launchUrl(
        mapsUrl,
        mode: LaunchMode.externalApplication, // Open in Google Maps app
      );
    } else {
      _showPopupNotif(
        'Error',
        'Tidak dapat membuka aplikasi peta.',
        isSuccess: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Barang',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
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
      ),
      backgroundColor: Colors.white,
      body: barangData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: barangData!['foto_barang_url'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  barangData!['foto_barang_url'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.broken_image,
                                          size: 50, color: Colors.grey),
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: Icon(Icons.image,
                                    color: Colors.grey, size: 50),
                              ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              updateStatusBarang(_status);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Simpan',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final alamat = barangData?['alamat_instansi'];
                              final namaInstansi = barangData?['nama_instansi'];

                              if (alamat != null && namaInstansi != null) {
                                // Combine alamat and namaInstansi into a single search query
                                final searchQuery = '$namaInstansi, $alamat';
                                openGoogleMaps(searchQuery);
                              } else {
                                _showPopupNotif(
                                  'Info',
                                  'Alamat atau nama instansi tidak tersedia untuk ditampilkan di peta.',
                                  isSuccess: false,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Lihat di Peta',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
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
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              value: _statusOptions.contains(_status) ? _status : null,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              items: _statusOptions.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value, style: GoogleFonts.poppins(fontSize: 14)),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) setState(() => _status = newValue);
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
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
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
}
