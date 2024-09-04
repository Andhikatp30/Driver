import 'dart:convert'; // for jsonDecode
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // for sending HTTP requests
import 'package:driver/ui/pages/home/home.dart';
import 'package:driver/ui/pages/loginsign/signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final url =
        Uri.parse('http://10.0.2.2/api/login.php'); // Replace with your IP

    final response = await http.post(url, body: {
      'username': emailController.text,
      'password': passwordController.text,
    });

    final data = jsonDecode(response.body);

    if (data['status'] == 'success') {
      String userName =
          data['name'] ?? 'User'; // Fallback in case 'name' is null
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(userName: userName),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );
    }
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
              height: 400,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                const SizedBox(height: 325),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45),
                    ),
                    color: Colors.teal,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Username",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        buildTextField(
                            emailController, 'Masukan username', Icons.person),
                        const SizedBox(height: 20),
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        buildPasswordTextField(
                            passwordController, _obscureText),
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
          ],
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

  Widget buildPasswordTextField(
      TextEditingController controller, bool obscureText) {
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
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        style: const TextStyle(color: Colors.black),
        obscureText: obscureText,
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
            color: Colors.deepPurple,
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
              fontWeight: FontWeight.normal,
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
