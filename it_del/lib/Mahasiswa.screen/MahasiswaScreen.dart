import 'package:flutter/material.dart';
import 'package:it_del/bottom.dart';
import 'package:it_del/Mahasiswa.screen/PemesananScreen.dart';
import 'package:it_del/Mahasiswa.screen/RequestIzinBermalam.dart';
import 'package:it_del/Mahasiswa.screen/RequestIzinKeluar.dart';
import 'package:it_del/Mahasiswa.screen/RequestRuangan.dart';
import 'package:it_del/Mahasiswa.screen/RequestSurat.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Services/User_service.dart';

class MahasiswaScreen extends StatefulWidget {
  const MahasiswaScreen({super.key});

  @override
  _MahasiswaScreenState createState() => _MahasiswaScreenState();
}

class _MahasiswaScreenState extends State<MahasiswaScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false)
                  });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Layanan BAAK DEL',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildDashboardItem(
                    context,
                    'Request Izin Keluar',
                    Icons.exit_to_app,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RequestIzinKeluarScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    'Request Izin Bermalam',
                    Icons.hotel,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RequestIzinBermalamScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    'Request Izin Surat',
                    Icons.assignment_add,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RequestSuratScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    'Booking Ruangan',
                    Icons.meeting_room,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RequestRuanganScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    'Pemesanan Baju',
                    Icons.add_shopping_cart_rounded,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => KaosPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onBottomNavBarItemTapped,
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context,
    String title,
    IconData iconData,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 5.0,
      color: Colors.blue,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 50.0, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
