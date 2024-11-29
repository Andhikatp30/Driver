import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:driver/ui/pages/home/home.dart';
import 'package:driver/ui/pages/history/detail.dart';

class History extends StatefulWidget {
  final String userName;

  const History({super.key, required this.userName});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> historyList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistoryData();
  }

  Future<void> fetchHistoryData() async {
    setState(() => isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/api/history.php'),
        body: {'kurirName': widget.userName},
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          if (mounted) {
            setState(() {
              historyList = List<Map<String, dynamic>>.from(data['data']);
            });
          }
        } else {
          _showErrorSnackbar('Error: ${data['message']}');
        }
      } else {
        _showErrorSnackbar('Failed to load history data');
      }
    } catch (e) {
      _showErrorSnackbar('Error fetching history data: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _refreshHistoryData() async {
    await fetchHistoryData();
  }

  void _showErrorSnackbar(String message) {
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
        onRefresh: _refreshHistoryData,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : historyList.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada riwayat pengiriman',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: historyList.length,
                      itemBuilder: (context, index) {
                        return HistoryCard(history: historyList[index]);
                      },
                    ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'History',
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
}

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> history;

  const HistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailRiwayat(pengiriman: history),
          ),
        );
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoText(
                      title: 'ID Pengiriman',
                      value: history['id_pengiriman'],
                      isBold: true,
                    ),
                    const SizedBox(height: 5),
                    buildInfoText(
                        title: 'ID Barang', value: history['id_barang']),
                    const SizedBox(height: 5),
                    buildInfoText(
                        title: 'Nama Barang', value: history['nama_barang']),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.info_outline,
                    color: Colors.blueAccent, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailRiwayat(pengiriman: history),
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

  Widget buildInfoText(
      {required String title, required String value, bool isBold = false}) {
    return Text(
      '$title: $value',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: isBold ? 18 : 16,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isBold ? Colors.black87 : Colors.black54,
        ),
      ),
    );
  }
}
