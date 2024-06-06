import 'package:flutter/material.dart';
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/request_izin_bermalam.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Services/IzinBermalam_service.dart';
import 'package:it_del/Services/globals.dart';
import 'package:it_del/Services/User_service.dart';
import 'package:intl/intl.dart';

class AproveIBScreen extends StatefulWidget {
  @override
  _AproveIBScreenState createState() => _AproveIBScreenState();
}

class _AproveIBScreenState extends State<AproveIBScreen> {
  List<dynamic> _izinbermalamlist = [];
  int userId = 0;
  bool _loading = true;

  Future<void> retrievePosts() async {
    try {
      userId = await getUserId();
      ApiResponse response = await getAdminIzinBermalam();

      if (response.error == null) {
        setState(() {
          _izinbermalamlist = response.data as List<dynamic>;
          _loading = _loading ? !_loading : _loading;
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

  void onViewIzinKeluar(RequestIzinBermalam izinKeluar) {
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
                  "Waktu Berangkat: ${DateFormat('yyyy-MM-dd HH:mm').format(izinKeluar.startDate)}"),
              Text(
                  "Waktu Kembali: ${DateFormat('yyyy-MM-dd HH:mm').format(izinKeluar.endDate)}"),
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

  void _approveIzinKeluar(int id) async {
    try {
      print("Attempting to approve leave request with ID: $id");

      ApiResponse response = await approveIbRequest(id);
      print("Response message: ${response.data}");

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Request Izin Bermalam Sudah Di Approve'),
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

  void _rejectedIzinKeluar(int id) async {
    try {
      print("Attempting to approve leave request with ID: $id");

      ApiResponse response = await rejectedIbRequest(id);
      print("Response message: ${response.data}");

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Request Izin Bermalam Sudah Di Reject'),
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
    // Call retrievePosts to fetch data when the screen is initialized
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izin Bermalam'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _izinbermalamlist.isEmpty
              ? Center(child: Text('Tidak Ada Request'))
              : ListView.builder(
                  itemCount: _izinbermalamlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    RequestIzinBermalam bookingruangan =
                        _izinbermalamlist[index];

                    // Format tanggal dan jam menggunakan DateFormat
                    String formattedStartDate = DateFormat('yyyy-MM-dd HH:mm')
                        .format(bookingruangan.startDate);
                    String formattedEndDate = DateFormat('yyyy-MM-dd HH:mm')
                        .format(bookingruangan.endDate);

                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          'Alasan: ${bookingruangan.reason}',
                          maxLines: 2, // Set the maximum number of lines
                          overflow: TextOverflow
                              .ellipsis, // Display ellipsis if text overflows
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status: ${bookingruangan.status}'),
                            Text('Waktu Berangkat: $formattedStartDate'),
                            Text('Waktu Kembali: $formattedEndDate'),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'rejected') {
                              _rejectedIzinKeluar(bookingruangan.id);
                            } else if (value == 'approve') {
                              _approveIzinKeluar(bookingruangan.id);
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
