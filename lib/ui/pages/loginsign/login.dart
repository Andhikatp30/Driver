// import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:driver/ui/pages/home/home.dart';
// import 'package:driver/ui/pages/loginsign/signin.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool _obscureText = true;
//   bool _isLoading = false;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> loginUser() async {
//     if (emailController.text.isEmpty || passwordController.text.isEmpty) {
//       _showWarningDialog('Incomplete Data', 'Harap isi username dan password!');
//       return;
//     }

//     setState(() => _isLoading = true);
//     final url = Uri.parse('http://10.0.2.2/api/login.php');

//     try {
//       final response = await http.post(url, body: {
//         'username': emailController.text,
//         'password': passwordController.text,
//       });

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           String userName = data['name'] ?? 'User';
//           String userUsername = data['username'] ?? '';

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Home(
//                 userName: userName,
//                 userUsername: userUsername,
//               ),
//             ),
//           );
//         } else {
//           _showSnackBar(data['message']);
//         }
//       } else {
//         _showSnackBar("Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       _showSnackBar("An error occurred. Please check your connection.");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _showWarningDialog(String title, String desc) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.warning,
//       animType: AnimType.bottomSlide,
//       title: title,
//       desc: desc,
//       btnOkOnPress: () {},
//       btnOkColor: Colors.orange,
//       btnOkText: 'OK',
//     ).show();
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Stack(
//           children: [
//             Image.asset(
//               "assets/images/logologin.png",
//               width: MediaQuery.of(context).size.width,
//               height: 375,
//               fit: BoxFit.cover,
//             ),
//             ListView(
//               children: [
//                 const SizedBox(height: 325),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(45)),
//                     color: Colors.teal,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 45),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Login",
//                             style: GoogleFonts.poppins(
//                               textStyle: const TextStyle(
//                                 fontSize: 28,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           "Selamat Datang Kembali di Aplikasi Driver Corner",
//                           style: GoogleFonts.poppins(
//                             textStyle: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 25),
//                         _buildLabel("Username"),
//                         const SizedBox(height: 12),
//                         buildTextField(
//                             emailController, 'Masukan username', Icons.person),
//                         const SizedBox(height: 20),
//                         _buildLabel("Password"),
//                         const SizedBox(height: 12),
//                         buildPasswordTextField(passwordController),
//                         const SizedBox(height: 35),
//                         buildLoginButton(),
//                         const SizedBox(height: 15),
//                         buildSignupPrompt(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (_isLoading)
//               const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         textStyle: const TextStyle(
//           fontSize: 16,
//           color: Colors.white,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(
//       TextEditingController controller, String hint, IconData icon) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: Icon(icon),
//         ),
//         style: const TextStyle(color: Colors.black),
//       ),
//     );
//   }

//   Widget buildPasswordTextField(TextEditingController controller) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: 'Masukan password',
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: const Icon(Icons.lock_outlined),
//           suffixIcon: IconButton(
//             icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
//             onPressed: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//           ),
//         ),
//         style: const TextStyle(color: Colors.black),
//         obscureText: _obscureText,
//       ),
//     );
//   }

//   Widget buildLoginButton() {
//     return ElevatedButton(
//       onPressed: loginUser,
//       style: ElevatedButton.styleFrom(
//         shape: const StadiumBorder(),
//         elevation: 8,
//         shadowColor: Colors.black,
//         backgroundColor: Colors.white,
//         minimumSize: const Size.fromHeight(45),
//       ),
//       child: Text(
//         "Masuk",
//         style: GoogleFonts.poppins(
//           textStyle: const TextStyle(
//             fontSize: 18,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSignupPrompt() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Belum punya akun?",
//           style: GoogleFonts.poppins(
//             textStyle: const TextStyle(
//               fontSize: 14,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => const Sign()));
//           },
//           child: Text(
//             "Daftar",
//             style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.lightBlueAccent,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:driver/ui/pages/home/home.dart';
import 'package:driver/ui/pages/loginsign/signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      final userName = prefs.getString('userName') ?? 'User';
      final userUsername = prefs.getString('userUsername') ?? '';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            userName: userName,
            userUsername: userUsername,
          ),
        ),
      );
    }
  }

  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showWarningDialog('Incomplete Data', 'Harap isi username dan password!');
      return;
    }

    setState(() => _isLoading = true);
    final url = Uri.parse('http://10.0.2.2/api/login.php');

    try {
      final response = await http.post(url, body: {
        'username': emailController.text,
        'password': passwordController.text,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          String userName = data['name'] ?? 'User';
          String userUsername = data['username'] ?? '';

          // Simpan data ke SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userName', userName);
          await prefs.setString('userUsername', userUsername);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                userName: userName,
                userUsername: userUsername,
              ),
            ),
          );
        } else {
          _showSnackBar(data['message']);
        }
      } else {
        _showSnackBar("Server error: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar("An error occurred. Please check your connection.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showWarningDialog(String title, String desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
      btnOkColor: Colors.orange,
      btnOkText: 'OK',
    ).show();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/logologin.png",
              width: MediaQuery.of(context).size.width,
              height: 375,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                const SizedBox(height: 325),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45)),
                    color: Colors.teal,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Selamat Datang Kembali di Aplikasi Driver Corner",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        _buildLabel("Username"),
                        const SizedBox(height: 12),
                        buildTextField(
                            emailController, 'Masukan username', Icons.person),
                        const SizedBox(height: 20),
                        _buildLabel("Password"),
                        const SizedBox(height: 12),
                        buildPasswordTextField(passwordController),
                        const SizedBox(height: 35),
                        buildLoginButton(),
                        const SizedBox(height: 15),
                        buildSignupPrompt(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller, String hint, IconData icon) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildPasswordTextField(TextEditingController controller) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Masukan password',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        style: const TextStyle(color: Colors.black),
        obscureText: _obscureText,
      ),
    );
  }

  Widget buildLoginButton() {
    return ElevatedButton(
      onPressed: loginUser,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 8,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(45),
      ),
      child: Text(
        "Masuk",
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildSignupPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun?",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Sign()));
          },
          child: Text(
            "Daftar",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}











// import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:driver/ui/pages/home/home.dart';
// import 'package:driver/ui/pages/loginsign/signin.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool _obscureText = true;
//   bool _isLoading = false;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> loginUser() async {
//     if (emailController.text.isEmpty || passwordController.text.isEmpty) {
//       _showWarningDialog('Incomplete Data', 'Harap isi username dan password!');
//       return;
//     }

//     setState(() => _isLoading = true);
//     final url =
//         Uri.parse('http://192.168.0.114/api/login.php');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'username': emailController.text,
//           'password': passwordController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Login response data: $data');
//         if (data['status'] == 'success') {
//           String userName = data['name'] ?? 'User';
//           String userUsername = data['username'] ?? '';

//           // Simpan status login dan informasi pengguna menggunakan SharedPreferences
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('isLoggedIn', true);
//           await prefs.setString('userName', userName);
//           await prefs.setString('userUsername', userUsername);

//           // Navigasi ke Home
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Home(
//                 userName: userName,
//                 userUsername: userUsername,
//               ),
//             ),
//           );
//         } else {
//           _showSnackBar(data['message']);
//         }
//       } else {
//         _showSnackBar("Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       _showSnackBar("An error occurred. Please check your connection.");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _showWarningDialog(String title, String desc) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.warning,
//       animType: AnimType.bottomSlide,
//       title: title,
//       desc: desc,
//       btnOkOnPress: () {},
//       btnOkColor: Colors.orange,
//       btnOkText: 'OK',
//     ).show();
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Stack(
//           children: [
//             Image.asset(
//               "assets/images/logologin.png",
//               width: MediaQuery.of(context).size.width,
//               height: 375,
//               fit: BoxFit.cover,
//             ),
//             ListView(
//               children: [
//                 const SizedBox(height: 325),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(45)),
//                     color: Colors.teal,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 45),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Login",
//                             style: GoogleFonts.poppins(
//                               textStyle: const TextStyle(
//                                 fontSize: 28,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           "Selamat Datang Kembali di Aplikasi Driver Corner",
//                           style: GoogleFonts.poppins(
//                             textStyle: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 25),
//                         _buildLabel("Username"),
//                         const SizedBox(height: 12),
//                         buildTextField(
//                             emailController, 'Masukan username', Icons.person),
//                         const SizedBox(height: 20),
//                         _buildLabel("Password"),
//                         const SizedBox(height: 12),
//                         buildPasswordTextField(passwordController),
//                         const SizedBox(height: 35),
//                         buildLoginButton(),
//                         const SizedBox(height: 15),
//                         buildSignupPrompt(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (_isLoading)
//               const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: GoogleFonts.poppins(
//         textStyle: const TextStyle(
//           fontSize: 16,
//           color: Colors.white,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(
//       TextEditingController controller, String hint, IconData icon) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: Icon(icon),
//         ),
//         style: const TextStyle(color: Colors.black),
//       ),
//     );
//   }

//   Widget buildPasswordTextField(TextEditingController controller) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: 'Masukan password',
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: const Icon(Icons.lock_outlined),
//           suffixIcon: IconButton(
//             icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
//             onPressed: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//           ),
//         ),
//         style: const TextStyle(color: Colors.black),
//         obscureText: _obscureText,
//       ),
//     );
//   }

//   Widget buildLoginButton() {
//     return ElevatedButton(
//       onPressed: loginUser,
//       style: ElevatedButton.styleFrom(
//         shape: const StadiumBorder(),
//         elevation: 8,
//         shadowColor: Colors.black,
//         backgroundColor: Colors.white,
//         minimumSize: const Size.fromHeight(45),
//       ),
//       child: Text(
//         "Masuk",
//         style: GoogleFonts.poppins(
//           textStyle: const TextStyle(
//             fontSize: 18,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSignupPrompt() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Belum punya akun?",
//           style: GoogleFonts.poppins(
//             textStyle: const TextStyle(
//               fontSize: 14,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => const Sign()));
//           },
//           child: Text(
//             "Daftar",
//             style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.lightBlueAccent,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
