import 'dart:convert';
import 'package:driver/ui/pages/loginsign/login.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  // Controllers to capture input data
  TextEditingController namaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  String selectedGender = 'Laki-laki'; // Default gender

  bool _obscureText = true;
  Color priaColor = Colors.blue[300]!;
  Color wanitaColor = Colors.white;

  void selectPria() {
    setState(() {
      selectedGender = 'Laki-laki';
      priaColor = Colors.blue[300]!;
      wanitaColor = Colors.white;
    });
  }

  void selectPerempuan() {
    setState(() {
      selectedGender = 'Perempuan';
      wanitaColor = Colors.blue[300]!;
      priaColor = Colors.white;
    });
  }

  // Function to register the user
  Future<void> registerKurir() async {
    final url = Uri.parse('http://10.0.2.2/api/register.php');
    final response = await http.post(url, body: {
      'nama': namaController.text,
      'username': usernameController.text,
      'password': passwordController.text,
      'gender': selectedGender,
      'umur': umurController.text,
      'alamat': alamatController.text,
    });

    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: "Success",
        desc: data['message'],
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        },
      ).show();
    } else {
      // Handle error
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: "Error",
        desc: data['message'],
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF009688), // Green background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Register',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildInputField('Nama', 'Masukan Nama', namaController),
              const SizedBox(height: 20),
              buildInputField(
                  'Username', 'Masukan Username', usernameController),
              const SizedBox(height: 20),
              Text(
                "Gender",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildGenderButton('Laki-laki', priaColor, selectPria),
                  buildGenderButton('Perempuan', wanitaColor, selectPerempuan),
                ],
              ),
              const SizedBox(height: 20),
              buildInputField('Umur', 'Masukan Umur', umurController),
              const SizedBox(height: 20),
              buildInputField('Alamat', 'Masukan Alamat', alamatController),
              const SizedBox(height: 20),
              buildPasswordField(),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  registerKurir(); // Call the function to register the user
                },
                child: buildRegisterButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
      String label, String placeholder, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGenderButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Masukan Password',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
            obscureText: _obscureText,
          ),
        ),
      ],
    );
  }

  Widget buildRegisterButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "Daftar",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}




// import 'package:driver/ui/pages/loginsign/login.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Sign extends StatefulWidget {
//   const Sign({super.key});

//   @override
//   State<Sign> createState() => _SignState();
// }

// class _SignState extends State<Sign> {
//   bool _obscureText = true;
//   Color priaColor = Colors.white;
//   Color wanitaColor = Colors.white;

//   final TextEditingController _namaController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _gender = '';

//   void selectPria() {
//     setState(() {
//       priaColor = Colors.blue[300]!;
//       wanitaColor = Colors.white;
//       _gender = 'Laki-laki';
//     });
//   }

//   void selectPerempuan() {
//     setState(() {
//       wanitaColor = Colors.blue[300]!;
//       priaColor = Colors.white;
//       _gender = 'Perempuan';
//     });
//   }

//   Future<void> registerUser() async {
//     print("registerUser dipanggil");

//     if (_namaController.text.isEmpty ||
//         _usernameController.text.isEmpty ||
//         _passwordController.text.isEmpty ||
//         _gender.isEmpty) {
//       print("Ada field yang kosong");
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.topSlide,
//         showCloseIcon: true,
//         title: "Error",
//         desc: "Semua field harus diisi!",
//         btnOkOnPress: () {},
//       ).show();
//       return;
//     }

//     try {
//       print("Mengirim data ke server...");
//       final response = await http.post(
//         Uri.parse(
//             'http://10.0.2.2/api/get_all_tables_data.php'), // Sesuaikan dengan URL API Anda
//         body: {
//           'name': _namaController.text,
//           'username': _usernameController.text,
//           'gender': _gender,
//           'password': _passwordController.text,
//         },
//       );

//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.body}");

//       if (response.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(response.body);
//           print("JSON response: $jsonResponse");

//           if (jsonResponse['status'] == 'success') {
//             print("Registrasi berhasil");
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.success,
//               animType: AnimType.topSlide,
//               showCloseIcon: true,
//               title: "Success",
//               desc:
//                   "Selamat akun kamu sudah terdaftar, harap diingat yah passwordnya >.<",
//               btnOkOnPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Login()),
//                 );
//               },
//             ).show();
//           } else {
//             print("Registrasi gagal: ${jsonResponse['message']}");
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.error,
//               animType: AnimType.topSlide,
//               showCloseIcon: true,
//               title: "Error",
//               desc: jsonResponse['message'],
//               btnOkOnPress: () {},
//             ).show();
//           }
//         } catch (e) {
//           print("Error decoding JSON: $e");
//           AwesomeDialog(
//             context: context,
//             dialogType: DialogType.error,
//             animType: AnimType.topSlide,
//             showCloseIcon: true,
//             title: "Error",
//             desc: "Kesalahan dalam memproses data dari server.",
//             btnOkOnPress: () {},
//           ).show();
//         }
//       } else {
//         print("Server error dengan status code: ${response.statusCode}");
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.error,
//           animType: AnimType.topSlide,
//           showCloseIcon: true,
//           title: "Error",
//           desc: "Terjadi kesalahan pada server.",
//           btnOkOnPress: () {},
//         ).show();
//       }
//     } catch (e) {
//       print("Exception: $e");
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.topSlide,
//         showCloseIcon: true,
//         title: "Error",
//         desc: "Tidak dapat terhubung ke server.",
//         btnOkOnPress: () {},
//       ).show();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF009688), // Warna latar hijau
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Register',
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.yellowAccent,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Silahkan lakukan registrasi dahulu\ndengan data dibawah ini',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               buildInputField('Name', 'Masukan Name', _namaController),
//               const SizedBox(height: 20),
//               buildInputField(
//                   'Username', 'Masukan Username', _usernameController),
//               const SizedBox(height: 20),
//               Text(
//                 "Gender",
//                 textAlign: TextAlign.left,
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.white,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   buildGenderButton('Laki-laki', priaColor, selectPria),
//                   buildGenderButton('Perempuan', wanitaColor, selectPerempuan),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               buildPasswordField(),
//               const SizedBox(height: 40),
//               GestureDetector(
//                 onTap: () {
//                   print("Tombol Daftar ditekan");
//                   registerUser();
//                 },
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     gradient: const LinearGradient(
//                       colors: [Colors.blue, Colors.purple],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Daftar",
//                       style: GoogleFonts.poppins(
//                         textStyle: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildInputField(
//       String label, String placeholder, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             textStyle: const TextStyle(
//               fontSize: 15,
//               color: Colors.white,
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           height: 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               hintText: placeholder,
//               hintStyle: const TextStyle(color: Colors.grey),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(25),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             style: const TextStyle(
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildGenderButton(String text, Color color, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 140,
//         height: 45,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(25),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPasswordField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Password",
//           textAlign: TextAlign.left,
//           style: GoogleFonts.poppins(
//             textStyle: const TextStyle(
//               fontSize: 15,
//               color: Colors.white,
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           height: 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: _passwordController,
//             decoration: InputDecoration(
//               hintText: 'Masukan Password',
//               hintStyle: const TextStyle(color: Colors.grey),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(25),
//                 borderSide: BorderSide.none,
//               ),
//               suffixIcon: IconButton(
//                 icon: Icon(
//                     _obscureText ? Icons.visibility : Icons.visibility_off),
//                 onPressed: () {
//                   setState(() {
//                     _obscureText = !_obscureText;
//                   });
//                 },
//               ),
//             ),
//             style: const TextStyle(
//               color: Colors.black,
//             ),
//             obscureText: _obscureText,
//           ),
//         ),
//       ],
//     );
//   }
// }
