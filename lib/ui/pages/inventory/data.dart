import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:driver/ui/pages/inventory/detail.dart';
import 'package:driver/ui/pages/home/home.dart';

class DataPengiriman extends StatefulWidget {
  final String userName;

  const DataPengiriman({super.key, required this.userName});

  @override
  _DataPengirimanState createState() => _DataPengirimanState();
}

class _DataPengirimanState extends State<DataPengiriman> {
  List<Map<String, dynamic>> pengirimanList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPengirimanData();
  }

  Future<void> fetchPengirimanData() async {
    setState(() => isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/api/pengiriman.php'),
        body: {'kurirName': widget.userName},
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          if (mounted) {
            setState(() {
              pengirimanList = List<Map<String, dynamic>>.from(data['data']);
            });
          }
        } else {
          _showError("Error: ${data['message']}");
        }
      } else {
        _showError("Failed to load pengiriman data: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Error fetching pengiriman data: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _refreshPengirimanData() async {
    await fetchPengirimanData();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: _refreshPengirimanData,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : pengirimanList.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada data pengiriman tersedia',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: pengirimanList.length,
                      itemBuilder: (context, index) {
                        return buildPengirimanCard(
                            pengirimanList[index], context);
                      },
                    ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Data Pengiriman',
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
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
    );
  }

  Widget buildPengirimanCard(
      Map<String, dynamic> pengiriman, BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetailPage(context, pengiriman),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Nama Barang: ${pengiriman['nama_barang']}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'ID Barang: ${pengiriman['id_barang']}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.info_outline,
                    color: Colors.blueAccent, size: 30),
                onPressed: () => _navigateToDetailPage(context, pengiriman),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetailPage(
      BuildContext context, Map<String, dynamic> pengiriman) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBarang(
          kurirName: widget.userName,
          idPengiriman: pengiriman['id_pengiriman'],
          fotoBarangUrl: pengiriman['foto_barang_url'],
        ),
      ),
    );
  }
}
