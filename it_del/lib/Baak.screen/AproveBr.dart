import 'package:flutter/material.dart';
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/booking_ruangan.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Services/RequestRuangan_service.dart';
import 'package:it_del/Services/globals.dart';
import 'package:it_del/Services/User_service.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Add other theme configurations as needed
      ),
      home: ApproveBrScreen(),
    );
  }
}

class ApproveBrScreen extends StatefulWidget {
  @override
  _ApproveBrScreenState createState() => _ApproveBrScreenState();
}

class _ApproveBrScreenState extends State<ApproveBrScreen> {
  List<dynamic> _izinkeluarlist = [];
  int userId = 0;
  bool _loading = true;

  Future<void> retrievePosts() async {
    try {
      userId = await getUserId();
      ApiResponse response = await getAdminRequestRuangan();

      if (response.error == null) {
        setState(() {
          _izinkeluarlist = response.data as List<dynamic>;
          _loading = false;
        });
      } else if (response.error == unauthrorized) {
        logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              )
            });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    } catch (e) {
      print("Error in retrievePosts: $e");
    }
  }

  void onViewIzinKeluar(BookingRuangan izinKeluar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Izin Bermalam Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Alasan: ${izinKeluar.reason}"),
              Text("Status: ${izinKeluar.status}"),
              Text(
                  "Waktu Booking Ruangan: ${DateFormat('yyyy-MM-dd HH:mm').format(izinKeluar.startDate)}"),
              Text(
                  "Waktu Ruangan Selesai: ${DateFormat('yyyy-MM-dd HH:mm').format(izinKeluar.endDate)}"),
              // Add more details as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _approveBookingRuangan(int id) async {
    try {
      print("Attempting to approve leave request with ID: $id");

      ApiResponse response = await approveBrRequest(id);
      print("Response message: ${response.data}");

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Request Booking Ruangan Sudah Di Approve'),
        ));

        // Refresh the list after approval
        retrievePosts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    } catch (e) {
      print("Error in _approveIzinKeluar: $e");
    }
  }

  void _rejectedBookingRuangan(int id) async {
    try {
      print("Attempting to approve leave request with ID: $id");

      ApiResponse response = await rejectedBrRequest(id);
      print("Response message: ${response.data}");

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Request Booking Ruangan Sudah Di Reject'),
        ));

        // Refresh the list after approval
        retrievePosts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    } catch (e) {
      print("Error in _approveIzinKeluar: $e");
    }
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Ruangan Screen'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _izinkeluarlist.isEmpty
              ? Center(child: Text('Tidak Ada Request'))
              : ListView.builder(
                  itemCount: _izinkeluarlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    BookingRuangan bookingruangan = _izinkeluarlist[index];

                    // Format tanggal dan jam menggunakan DateFormat
                    String formattedStartDate = DateFormat('yyyy-MM-dd HH:mm')
                        .format(bookingruangan.startDate);
                    String formattedEndDate = DateFormat('yyyy-MM-dd HH:mm')
                        .format(bookingruangan.endDate);

                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Reason: ${bookingruangan.reason}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID Mahasiswa: ${bookingruangan.userId}'),
                            Text('Ruangan: ${bookingruangan.ruangan_name}'),
                            Text('Status: ${bookingruangan.status}'),
                            Text('Waktu Booking Ruangan: $formattedStartDate'),
                            Text(
                                'Waktu Booking Ruangan Selesai: $formattedEndDate'),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'approve') {
                              _approveBookingRuangan(bookingruangan.id);
                            } else if (value == 'rejected') {
                              _rejectedBookingRuangan(bookingruangan.id);
                            } else if (value == 'view') {
                              onViewIzinKeluar(bookingruangan);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              {'label': 'Approved', 'icon': Icons.thumb_up},
                              {'label': 'Rejected', 'icon': Icons.thumb_down},
                              {'label': 'View', 'icon': Icons.remove_red_eye},
                            ].map((Map<String, dynamic> choice) {
                              return PopupMenuItem<String>(
                                value: choice['label'].toLowerCase(),
                                child: ListTile(
                                  leading: Icon(choice['icon']),
                                  title: Text(choice['label']),
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
