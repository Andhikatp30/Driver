// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';

// import 'package:driver/ui/pages/history/history.dart';
// import 'package:driver/ui/pages/company/company.dart';
// import 'package:driver/ui/pages/inventory/data.dart';
// import 'package:driver/ui/pages/profile/profile.dart';
// // import 'package:driver/ui/pages/maps/maps.dart';

// class Home extends StatefulWidget {
//   final String userName;
//   final String userUsername;

//   // ignore: use_super_parameters
//   const Home({
//     Key? key,
//     required this.userName,
//     required this.userUsername,
//   }) : super(key: key);

//   @override
//   HomeState createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   int _selectedIndex = 0;

//   void onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: no_leading_underscores_for_local_identifiers
//     final List<Widget> _pages = [
//       HomeContent(userName: widget.userName),
//       DataPengiriman(userName: widget.userName),
//       // const MapsPage(
//       //   address: 'Sample Address',
//       // ), // Tambahkan halaman Maps baru
//       History(userName: widget.userName),
//       Profile(
//         name: widget.userName,
//         username: widget.userUsername,
//       ),
//     ];

//     return Scaffold(
//       body: _pages[_selectedIndex],
//       //     body: AnimatedSwitcher(
//       //   duration: const Duration(milliseconds: 500),
//       //   transitionBuilder: (Widget child, Animation<double> animation) {
//       //     return FadeTransition(opacity: animation, child: child);
//       //   },
//       //   child: _pages[_selectedIndex],
//       // ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.inventory),
//             label: '',
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.map), // Menambahkan ikon untuk Maps
//           //   label: '',
//           // ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.green[800],
//         unselectedItemColor: Colors.grey[400],
//         onTap: onItemTapped,
//       ),
//     );
//   }
// }

// class HomeContent extends StatefulWidget {
//   final String userName;

//   const HomeContent({super.key, required this.userName});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeContentState createState() => _HomeContentState();
// }

// class _HomeContentState extends State<HomeContent> {
//   List<Map<String, dynamic>> notifications = [];
//   bool isLoading = true;
//   String kurirName = '';

//   @override
//   void initState() {
//     super.initState();
//     kurirName = widget.userName;
//     fetchNotifications();
//   }

//   Future<void> fetchNotifications() async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2/api/notif.php'),
//         body: {'kurirName': kurirName},
//         headers: {"Content-Type": "application/x-www-form-urlencoded"},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           setState(() {
//             notifications =
//                 List<Map<String, dynamic>>.from(data['notifications']);
//                 isLoading = false;
//           });
//         } else {
//           // ignore: avoid_print
//           print('Error: ${data['message']}');
//           setState(() => isLoading = false);
//         }
//       } else {
//         // ignore: avoid_print
//         print('Failed to load notifications: ${response.statusCode}');
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       // ignore: avoid_print
//       print('Error fetching notifications: $e');
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF009688), Color(0xFF004D40)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 30,
//                     backgroundImage: AssetImage('assets/images/avatar.png'),
//                   ),
//                   const SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.userName,
//                         style: GoogleFonts.poppins(
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.yellowAccent,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Selamat datang kembali!',
//                         style: GoogleFonts.poppins(
//                           textStyle: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 'Dashboard',
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             buildDashboardCard(
//               context,
//               'Inventory',
//               'Data Pengiriman',
//               'assets/images/inventory.png',
//               const Color(0xFF04A5A5),
//               onTap: () {
//                 final homeState = context.findAncestorStateOfType<HomeState>();
//                 homeState?.onItemTapped(1);
//               },
//             ),
//             const SizedBox(height: 20),
//             buildDashboardCard(
//               context,
//               'History',
//               'Riwayat',
//               'assets/images/history.png',
//               const Color(0xFF04A5A5),
//               onTap: () {
//                 final homeState = context.findAncestorStateOfType<HomeState>();
//                 homeState?.onItemTapped(2);
//               },
//             ),
//             const SizedBox(height: 20),
//             buildDashboardCard(
//               context,
//               'Company Profile',
//               'Profil Perusahaan',
//               'assets/images/company.png',
//               const Color(0xFF04A5A5),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const CompanyProfile()),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//             const Divider(thickness: 1),
//             Center(
//               child: Text(
//                 'Barang Pengiriman',
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ),
//             const Divider(thickness: 1),
//             const SizedBox(height: 10),
//             ...notifications
//                 .map((notif) => buildNotificationCard(context, notif)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDashboardCard(BuildContext context, String title, String subtitle,
//       String iconPath, Color bgColor,
//       {VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(15),
//           gradient: LinearGradient(
//             colors: [bgColor, bgColor.withOpacity(0.7)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   iconPath,
//                   width: 50,
//                   height: 50,
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: GoogleFonts.poppins(
//                         textStyle: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       subtitle,
//                       style: GoogleFonts.poppins(
//                         textStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: onTap,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: Text(
//                 'Lihat',
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.purple,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildNotificationCard(
//       BuildContext context, Map<String, dynamic> notif) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.teal[600],
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.notification_important, color: Colors.yellowAccent),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ID Pengiriman: ${notif['id_pengiriman']}',
//                   style: GoogleFonts.poppins(
//                     textStyle: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   'ID Barang: ${notif['id_barang']}',
//                   style: GoogleFonts.poppins(
//                     textStyle: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 Text(
//                   'Nama Barang: ${notif['nama_barang']}',
//                   style: GoogleFonts.poppins(
//                     textStyle: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:driver/ui/pages/history/history.dart';
import 'package:driver/ui/pages/company/company.dart';
import 'package:driver/ui/pages/inventory/data.dart';
import 'package:driver/ui/pages/profile/profile.dart';
import 'package:driver/ui/pages/loginsign/login.dart';

class Home extends StatefulWidget {
  final String userName;
  final String userUsername;

  const Home({
    Key? key,
    required this.userName,
    required this.userUsername,
  }) : super(key: key);

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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userName');
    await prefs.remove('userUsername');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeContent(userName: widget.userName),
      DataPengiriman(userName: widget.userName),
      History(userName: widget.userName),
      Profile(
        name: widget.userName,
        username: widget.userUsername,
        onLogout: logout, // Pass the logout function to Profile page
      ),
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
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey[400],
        onTap: onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final String userName;

  const HomeContent({super.key, required this.userName});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;
  String kurirName = '';

  @override
  void initState() {
    super.initState();
    kurirName = widget.userName;
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    setState(() => isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/api/notif.php'),
        body: {'kurirName': kurirName},
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            notifications =
                List<Map<String, dynamic>>.from(data['notifications']);
          });
        } else {
          _showErrorSnackbar(data['message']);
        }
      } else {
        _showErrorSnackbar('Failed to load notifications');
      }
    } catch (e) {
      _showErrorSnackbar('Error fetching notifications: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _refreshNotifications() async {
    await fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshNotifications,
      child: SingleChildScrollView(
        physics:
            const AlwaysScrollableScrollPhysics(), // Ensures scrollability even when content is short
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            const SizedBox(height: 20),
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
            buildDashboardSection(context),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            Center(
              child: Text(
                'Barang Pengiriman',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: notifications
                    .map((notif) => buildNotificationCard(context, notif))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF009688), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
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
                widget.userName,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Selamat datang kembali!',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDashboardSection(BuildContext context) {
    return Column(
      children: [
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
        buildDashboardCard(
          context,
          'Company Profile',
          'Profil Perusahaan',
          'assets/images/company.png',
          const Color(0xFF04A5A5),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CompanyProfile()),
            );
          },
        ),
      ],
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
          gradient: LinearGradient(
            colors: [bgColor, bgColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                  fontSize: 14,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
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
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal[600],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
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
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'ID Barang: ${notif['id_barang']}',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                Text(
                  'Nama Barang: ${notif['nama_barang']}',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//notif
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:driver/ui/pages/history/history.dart';
// import 'package:driver/ui/pages/company/company.dart';
// import 'package:driver/ui/pages/inventory/data.dart';
// import 'package:driver/ui/pages/profile/profile.dart';
// import 'package:driver/ui/pages/loginsign/login.dart';

// class Home extends StatefulWidget {
//   final String userName;
//   final String userUsername;

//   const Home({
//     Key? key,
//     required this.userName,
//     required this.userUsername,
//   }) : super(key: key);

//   @override
//   HomeState createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   int _selectedIndex = 0;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     initializeNotifications();
//   }

//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('isLoggedIn');
//     await prefs.remove('userName');
//     await prefs.remove('userUsername');

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const Login()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _pages = [
//       HomeContent(
//           userName: widget.userName,
//           notificationsPlugin: flutterLocalNotificationsPlugin),
//       DataPengiriman(userName: widget.userName),
//       History(userName: widget.userName),
//       Profile(
//         name: widget.userName,
//         username: widget.userUsername,
//         onLogout: logout,
//       ),
//     ];

//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.inventory),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.green[800],
//         unselectedItemColor: Colors.grey[400],
//         onTap: onItemTapped,
//       ),
//     );
//   }
// }

// class HomeContent extends StatefulWidget {
//   final String userName;
//   final FlutterLocalNotificationsPlugin notificationsPlugin;

//   const HomeContent(
//       {Key? key, required this.userName, required this.notificationsPlugin})
//       : super(key: key);

//   @override
//   _HomeContentState createState() => _HomeContentState();
// }

// class _HomeContentState extends State<HomeContent> {
//   List<Map<String, dynamic>> notifications = [];
//   bool isLoading = true;
//   String kurirName = '';

//   @override
//   void initState() {
//     super.initState();
//     kurirName = widget.userName;
//     fetchNotifications();
//   }

//   Future<void> fetchNotifications() async {
//     setState(() => isLoading = true);
//     try {
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2/api/notif.php'),
//         body: {'kurirName': kurirName},
//         headers: {"Content-Type": "application/x-www-form-urlencoded"},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           List<Map<String, dynamic>> newNotifications =
//               List<Map<String, dynamic>>.from(data['notifications']);

//           // Bandingkan dengan notifikasi yang sudah ada
//           List<Map<String, dynamic>> newEntries =
//               newNotifications.where((newNotif) {
//             return !notifications.any((oldNotif) =>
//                 oldNotif['id_pengiriman'] == newNotif['id_pengiriman']);
//           }).toList();

//           if (newEntries.isNotEmpty) {
//             setState(() {
//               notifications = newNotifications; // Update daftar notifikasi
//             });

//             // Menampilkan notifikasi lokal untuk data baru
//             await showLocalNotification(
//               'Notifikasi Baru',
//               'Anda memiliki ${newEntries.length} notifikasi baru',
//             );
//           }
//         } else {
//           _showErrorSnackbar(data['message']);
//         }
//       } else {
//         _showErrorSnackbar('Failed to load notifications');
//       }
//     } catch (e) {
//       _showErrorSnackbar('Error fetching notifications: $e');
//     } finally {
//       if (mounted) {
//         setState(() => isLoading = false);
//       }
//     }
//   }

//   Future<void> showLocalNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('channel_id', 'channel_name',
//             importance: Importance.max, priority: Priority.high);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await widget.notificationsPlugin
//         .show(0, title, body, platformChannelSpecifics);
//   }

//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   Future<void> _refreshNotifications() async {
//     await fetchNotifications();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: _refreshNotifications,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildHeader(),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 'Dashboard',
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             buildDashboardSection(context),
//             const SizedBox(height: 20),
//             const Divider(thickness: 1),
//             Center(
//               child: Text(
//                 'Barang Pengiriman',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             const Divider(thickness: 1),
//             const SizedBox(height: 10),
//             if (isLoading)
//               const Center(child: CircularProgressIndicator())
//             else
//               Column(
//                 children: notifications
//                     .map((notif) => buildNotificationCard(context, notif))
//                     .toList(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF009688), Color(0xFF004D40)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage('assets/images/avatar.png'),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.userName,
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.yellowAccent,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Selamat datang kembali!',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDashboardSection(BuildContext context) {
//     return Column(
//       children: [
//         buildDashboardCard(
//           context,
//           'Inventory',
//           'Data Pengiriman',
//           'assets/images/inventory.png',
//           const Color(0xFF04A5A5),
//           onTap: () {
//             final homeState = context.findAncestorStateOfType<HomeState>();
//             homeState?.onItemTapped(1);
//           },
//         ),
//         const SizedBox(height: 20),
//         buildDashboardCard(
//           context,
//           'History',
//           'Riwayat',
//           'assets/images/history.png',
//           const Color(0xFF04A5A5),
//           onTap: () {
//             final homeState = context.findAncestorStateOfType<HomeState>();
//             homeState?.onItemTapped(2);
//           },
//         ),
//         const SizedBox(height: 20),
//         buildDashboardCard(
//           context,
//           'Company Profile',
//           'Profil Perusahaan',
//           'assets/images/company.png',
//           const Color(0xFF04A5A5),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const CompanyProfile()),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildDashboardCard(BuildContext context, String title, String subtitle,
//       String iconPath, Color bgColor,
//       {VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(15),
//           gradient: LinearGradient(
//             colors: [bgColor, bgColor.withOpacity(0.7)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   iconPath,
//                   width: 50,
//                   height: 50,
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       subtitle,
//                       style: GoogleFonts.poppins(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: onTap,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: Text(
//                 'Lihat',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   color: Colors.purple,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildNotificationCard(
//       BuildContext context, Map<String, dynamic> notif) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.teal[600],
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.notification_important, color: Colors.yellowAccent),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ID Pengiriman: ${notif['id_pengiriman']}',
//                   style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   'ID Barang: ${notif['id_barang']}',
//                   style: GoogleFonts.poppins(color: Colors.white),
//                 ),
//                 Text(
//                   'Nama Barang: ${notif['nama_barang']}',
//                   style: GoogleFonts.poppins(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
