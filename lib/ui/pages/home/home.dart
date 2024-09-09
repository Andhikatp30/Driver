import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Import http package

import 'package:driver/ui/pages/history/history.dart';
import 'package:driver/ui/pages/company/company.dart';
import 'package:driver/ui/pages/inventory/data.dart';
import 'package:driver/ui/pages/profile/profile.dart';

class Home extends StatefulWidget {
  final String userName; // Add a userName parameter

  // ignore: use_super_parameters
  const Home({Key? key, required this.userName})
      : super(key: key); // Make userName required

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final List<Widget> _pages = [
      HomeContent(userName: widget.userName),
      DataPengiriman(userName: widget.userName),
      History(userName: widget.userName),
      const Profile(),
    ];
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final String userName; // Add a userName parameter to HomeContent

  const HomeContent(
      {super.key, required this.userName}); // Make userName required

  @override
  // ignore: library_private_types_in_public_api
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Map<String, dynamic>> notifications = [];
  String kurirName = ''; // Nama kurir yang digunakan untuk notifikasi

  @override
  void initState() {
    super.initState();
    kurirName = widget.userName;
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/api/notif.php'), // Ganti dengan URL API yang benar
        body: {
          'kurirName': kurirName
        }, // Pastikan 'kurirName' dikirim sebagai parameter
        headers: {
          "Content-Type":
              "application/x-www-form-urlencoded" // Menyertakan header untuk permintaan POST
        },
      );

      // ignore: avoid_print
      print('Response status: ${response.statusCode}');
      // ignore: avoid_print
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            notifications =
                List<Map<String, dynamic>>.from(data['notifications']);
          });
        } else {
          // ignore: avoid_print
          print(
              'Error: ${data['message']}'); // Pesan error jika tidak ada notifikasi
        }
      } else {
        // ignore: avoid_print
        print('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and welcome message
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF009688),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName, // Display the passed userName here
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Selamat datang kembali!',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
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
            const SizedBox(height: 20),

            // Dashboard Heading
            Center(
              child: Text(
                'Dashboard',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Card Inventory
            buildDashboardCard(
              context,
              'Inventory',
              'Data Pengiriman',
              'assets/images/inventory.png',
              const Color(0xFF04A5A5),
              onTap: () {
                final homeState = context.findAncestorStateOfType<HomeState>();
                homeState?.onItemTapped(1);
              },
            ),

            const SizedBox(height: 20),

            // Card History
            buildDashboardCard(
              context,
              'History',
              'Riwayat',
              'assets/images/history.png',
              const Color(0xFF04A5A5),
              onTap: () {
                final homeState = context.findAncestorStateOfType<HomeState>();
                homeState?.onItemTapped(2);
              },
            ),

            const SizedBox(height: 20),

            // Card Company Profile
            buildDashboardCard(
              context,
              'Company Profile',
              'Profil Perusahaan',
              'assets/images/company.png',
              const Color(0xFF04A5A5),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompanyProfile()),
                );
              },
            ),

            const SizedBox(height: 20),

            // Notification
            const Divider(thickness: 1),
            Center(
              child: Text(
                'Notifikasi',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),

            // Render Notification Cards from Database
            ...notifications
                .map((notif) => buildNotificationCard(context, notif))
                // ignore: unnecessary_to_list_in_spreads
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardCard(BuildContext context, String title, String subtitle,
      String iconPath, Color bgColor,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Lihat',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationCard(
      BuildContext context, Map<String, dynamic> notif) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8), // Menambahkan margin vertikal antara kartu
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal[600],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.notification_important, color: Colors.yellowAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID Pengiriman: ${notif['id_pengiriman']}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'ID Barang: ${notif['id_barang']}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  'Nama Barang: ${notif['nama_barang']}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
