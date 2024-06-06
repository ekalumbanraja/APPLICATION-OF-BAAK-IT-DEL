import 'package:flutter/material.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Screens/register_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('CIS IT DEL'), // Warna header
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo di bagian atas
            SizedBox(
              height: 100,
              child: Image.asset('assets/logo.jpg'),
            ),
            const SizedBox(height: 30),
            // Tombol Login dan Registrasi dalam satu baris
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(
                    width:
                        25), // Tambahkan sedikit ruang putih di antara tombol
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman registrasi
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Registrasi'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
