import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  final String currentName;
  final String currentUsername;

  const EditProfile({
    super.key,
    required this.currentName,
    required this.currentUsername,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai yang diterima
    nameController = TextEditingController(text: widget.currentName);
    usernameController = TextEditingController(text: widget.currentUsername);
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Bersihkan controller ketika tidak digunakan untuk menghindari kebocoran memori
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    // URL endpoint API Anda
    const String apiUrl =
        'http://10.0.2.2/api/editProfile.php'; // Gantilah dengan URL API Anda

    // Data yang akan dikirimkan ke API
    final Map<String, String> body = {
      'name': nameController.text,
      'username': usernameController.text,
      'password': passwordController.text,
    };

    // try {
    //   // Kirim permintaan POST ke API
    //   final response = await http.post(Uri.parse(apiUrl), body: body);

    //   if (response.statusCode == 200) {
    //     // Jika berhasil, tampilkan pesan sukses
    //     // ignore: use_build_context_synchronously
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Profil berhasil diperbarui!')),
    //     );
    //   } else {
    //     // Jika gagal, tampilkan pesan kesalahan
    //     // ignore: use_build_context_synchronously
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Gagal memperbarui profil.')),
    //     );
    //   }
    // } catch (e) {
    //   // Tangani kesalahan yang terjadi
    //   // ignore: use_build_context_synchronously
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Terjadi kesalahan: $e')),
    //   );
    // }
    try {
      final response = await http.post(Uri.parse(apiUrl), body: body);
      // ignore: avoid_print
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        _showSnackBar(
            'Profil berhasil diperbarui!', Colors.green, Icons.check_circle);
        // ignore: use_build_context_synchronously
        Navigator.pop(context,
            {'name': nameController.text, 'username': usernameController.text});
      } else {
        _showSnackBar('Gagal memperbarui profil.', Colors.red, Icons.error);
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan: $e', Colors.red, Icons.error);
    }
  }

  void _showSnackBar(String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Profile',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(' › '),
            Text(
              'Edit Profile',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            buildTextField('Nama', nameController),
            const SizedBox(height: 15),
            buildTextField('Username', usernameController),
            const SizedBox(height: 15),
            buildTextField('Password', passwordController,
                obscureText: true), // Tambahkan field untuk password
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed:
                  _saveProfile, // Panggil fungsi _saveProfile saat tombol ditekan
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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

  Widget buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
