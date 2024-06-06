import 'package:flutter/material.dart';
import 'package:it_del/Baak.screen/History/AproveBr1.dart';
import 'package:it_del/Baak.screen/History/AproveIB2.dart';
import 'package:it_del/Baak.screen/History/AproveIK3.dart';
import 'package:it_del/Baak.screen/History/AproveSurat4.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Services/User_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('History'),
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
              'History',
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
                    Icons.add_circle,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AproveIKScreen3(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    'Request Izin Bermalam',
                    Icons.access_time,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AproveIBScreen2(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    'Request Izin Surat',
                    Icons.access_time,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ApproveSuratScreen4(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    'Booking Ruangan',
                    Icons.access_time,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ApproveBrScreen1(),
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
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 50.0, color: Colors.blue),
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
}
