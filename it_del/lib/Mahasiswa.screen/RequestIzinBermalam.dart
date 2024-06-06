import 'package:flutter/material.dart';
import 'package:it_del/bottom.dart';
import 'package:it_del/Mahasiswa.screen/FormIzinBermalam.dart';
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/request_izin_bermalam.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Services/IzinBermalam_service.dart';
import 'package:it_del/Services/globals.dart';
import 'package:it_del/Services/User_service.dart';
import 'package:intl/intl.dart';

class RequestIzinBermalamScreen extends StatefulWidget {
  @override
  _RequestIzinBermalamScreenState createState() =>
      _RequestIzinBermalamScreenState();
}

class _RequestIzinBermalamScreenState extends State<RequestIzinBermalamScreen> {
  List<dynamic> _izinbermalamlist = [];
  int userId = 0;
  bool _loading = true;
  int _selectedIndex = 0;

  Future<void> retrievePosts() async {
    try {
      userId = await getUserId();
      ApiResponse response = await getIzinBermalam();

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

  void _navigateToAddData() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FormIzinBermalams(
              title: 'Request Izin Bermalam',
            )));
  }

  void deleteIzinBermalam(int id) async {
    try {
      ApiResponse response = await DeleteIzinBermalam(id);

      if (response.error == null) {
        await Future.delayed(Duration(milliseconds: 300));
        // Update the state to trigger a rebuild
        setState(() {
          _izinbermalamlist.removeWhere((item) => item.id == id);
        });
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                onPressed: _navigateToAddData,
                icon: const Icon(Icons.add, size: 24),
                label: const Text('Request Izin Bermalam',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowHeight: 47, // Adjust the row height as needed
                      columnSpacing: 20,
                      headingRowColor: MaterialStateColor.resolveWith((states) {
                        return Colors.grey[300]!;
                      }),
                      columns: const [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Keperluan')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: _izinbermalamlist.map((bookingruangan) {
                        return DataRow(
                          color: MaterialStateColor.resolveWith((states) {
                            return _getColorForStatus(
                                bookingruangan.status ?? '');
                          }),
                          cells: [
                            DataCell(Text(
                                '${_izinbermalamlist.indexOf(bookingruangan) + 1}')),
                            DataCell(
                              Container(
                                width: 150, // Adjust the width as needed
                                child: Text(
                                  bookingruangan.reason,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(Text(bookingruangan.status)),
                            DataCell(PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  int index =
                                      _izinbermalamlist.indexOf(bookingruangan);
                                  RequestIzinBermalam selectedIzinKeluar =
                                      _izinbermalamlist[index];

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FormIzinBermalams(
                                      title: "Edit Izin Bermalam",
                                      formIzinBermalam: selectedIzinKeluar,
                                    ),
                                  ));
                                } else if (value == 'cancel') {
                                  deleteIzinBermalam(bookingruangan.id);
                                } else if (value == 'view') {
                                  onViewIzinKeluar(bookingruangan);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                // Create conditions to determine whether to show the "Edit" and "Cancel" options

                                bool canEdit =
                                    (bookingruangan.status != 'rejected' &&
                                        bookingruangan.status != 'approved');
                                bool canCancel =
                                    (bookingruangan.status != 'rejected' &&
                                        bookingruangan.status != 'approved');

                                List<Map<String, dynamic>> menuOptions = [];

                                if (canEdit) {
                                  menuOptions.add({
                                    'value': 'edit',
                                    'label': 'Edit',
                                    'icon': Icons.edit,
                                  });
                                }
                                if (canCancel) {
                                  menuOptions.add({
                                    'value': 'cancel',
                                    'label': 'Cancel',
                                    'icon': Icons.cancel,
                                  });
                                }

                                menuOptions.add({
                                  'value': 'view',
                                  'label': 'View',
                                  'icon': Icons.remove_red_eye,
                                });

                                return menuOptions
                                    .map((Map<String, dynamic> option) {
                                  return PopupMenuItem<String>(
                                    value: option['value'].toLowerCase(),
                                    child: Row(
                                      children: [
                                        Icon(option['icon']),
                                        const SizedBox(width: 8.0),
                                        Text(option['label']),
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onBottomNavBarItemTapped,
      ),
    );
  }

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getColorForStatus(String status) {
    switch (status.toLowerCase()) {
      case 'rejected':
        return Colors.red; // Change to the desired color for rejected status
      case 'approved':
        return Colors.green; // Change to the desired color for approved status
      default:
        return Colors.yellow; // Change to the desired color for other statuses
    }
  }
}
