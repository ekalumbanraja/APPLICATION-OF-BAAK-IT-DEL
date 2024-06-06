import 'package:flutter/material.dart';
import 'package:it_del/Mahasiswa.screen/FormRequestSurat.dart';
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/request_surat.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Services/RequestSurat.dart';
import 'package:it_del/Services/globals.dart';
import 'package:it_del/Services/User_service.dart';

class ApproveSuratScreen extends StatefulWidget {
  const ApproveSuratScreen({super.key});

  @override
  _ApproveSuratState createState() => _ApproveSuratState();
}

class _ApproveSuratState extends State<ApproveSuratScreen> {
  List<dynamic> _suratlist = [];
  int userId = 0;
  bool _loading = true;

  Future<void> retrievePosts() async {
    try {
      userId = await getUserId();
      ApiResponse response = await getAdminSurat();

      if (response.error == null) {
        setState(() {
          _suratlist = response.data as List<dynamic>;
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

  void _navigateToAddData() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FormRequestSurats(
              title: 'Request Izin Keluar',
            )));
  }

  void deleteIzinKeluar(int id) async {
    try {
      ApiResponse response = await DeleteRequestSurat(id);

      if (response.error == null) {
        await Future.delayed(
            const Duration(milliseconds: 300)); // Add this line
        Navigator.pop(context); // Close the confirmation dialog
        retrievePosts(); // Move retrievePosts after the dialog is closed
      } else if (response.error == unauthrorized) {
        // ... (unchanged)
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    } catch (e) {
      print("Error in deleteIzinKeluar: $e");
    }
  }

  void _approveIzinKeluar(int id) async {
    try {
      print("Attempting to approve leave request with ID: $id");

      ApiResponse response = await approveSuratRequest(id);
      print("Response message: ${response.data}");

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Surat Sudah Di Approve.'),
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

      ApiResponse response = await rejectedSuratRequest(id);
      print("Response message: ${response.data}");

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Surat Sudah Di Reject'),
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

  void onViewIzinKeluar(RequestSurat izinKeluar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Surat Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Alasan: ${izinKeluar.reason}"),
              Text("Status: ${izinKeluar.status}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
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
        title: const Text('Surat'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _suratlist.isEmpty
              ? const Center(child: Text('Tidak Ada Request'))
              : ListView.builder(
                  itemCount: _suratlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    RequestSurat bookingruangan = _suratlist[index];

                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          'Alasan: ${bookingruangan.reason}',
                          maxLines: 2, // Set the maximum number of lines
                          overflow: TextOverflow
                              .ellipsis, // Display ellipsis if text overflows
                        ),
                        // ... rest of your ListTile code
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status: ${bookingruangan.status}'),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'approved') {
                              _approveIzinKeluar(bookingruangan.id ?? 0);
                            } else if (value == 'rejected') {
                              _rejectedIzinKeluar(bookingruangan.id ?? 0);
                            } else if (value == 'view') {
                              // Handle the 'View' option
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
