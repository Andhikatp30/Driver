import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:driver/ui/pages/company/company.dart'; // Pastikan untuk menambahkan ini

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan avatar dan teks selamat datang
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF009688),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/avatar.png'), // Ganti dengan gambar Anda
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Andhika Trisna Putra',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
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
              Text(
                'Dashboard',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Card Inventory
              buildDashboardCard(
                context,
                'Inventory',
                'Data Pengiriman',
                'assets/images/inventory.png', // Ganti dengan ikon yang sesuai
                const Color(0xFF04A5A5), // Warna latar belakang card
                onTap: () {
                  // Tambahkan navigasi ke halaman lain jika diperlukan
                },
              ),

              const SizedBox(height: 20),

              // Card History
              buildDashboardCard(
                context,
                'History',
                'Riwayat',
                'assets/images/history.png', // Ganti dengan ikon yang sesuai
                const Color(0xFF04A5A5), // Warna latar belakang card
                onTap: () {
                  // Tambahkan navigasi ke halaman lain jika diperlukan
                },
              ),

              const SizedBox(height: 20),

              // Card Company Profile
              buildDashboardCard(
                context,
                'Company Profile',
                'Profil Perusahaan',
                'assets/images/company.png', // Ganti dengan ikon yang sesuai
                const Color(0xFF04A5A5), // Warna latar belakang card
                borderColor: Colors.blue, // Border biru untuk card terakhir
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompanyProfile()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Notifikasi
              const Divider(thickness: 1),
              Center(
                child: Text(
                  'Notifikasi',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 10),

              // Notifikasi Cards
              buildNotificationCard(context,
                  'Barang dengan ID: (xxxxxxxxx) berhasil ditambahkan ke dalam inventory Anda!'),
              const SizedBox(height: 10),
              buildNotificationCard(context,
                  'Barang dengan ID: (xxxxxxxxx) berhasil ditambahkan ke dalam inventory Anda!'),
              const SizedBox(height: 10),
              buildNotificationCard(context,
                  'Barang dengan ID: (xxxxxxxxx) berhasil ditambahkan ke dalam inventory Anda!'),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
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
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget buildDashboardCard(BuildContext context, String title, String subtitle,
      String iconPath, Color bgColor,
      {Color? borderColor, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 2)
              : null,
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
                  width: 70,
                  height: 70,
                ),
                const SizedBox(width: 16),
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

  Widget buildNotificationCard(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal[600],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.notification_important, color: Colors.yellow),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}