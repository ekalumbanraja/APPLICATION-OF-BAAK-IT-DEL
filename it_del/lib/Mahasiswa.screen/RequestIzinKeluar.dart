import 'package:flutter/material.dart';
import 'package:it_del/bottom.dart';
import 'package:it_del/Mahasiswa.screen/FormIzinKeluar.dart';
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/request_izin_keluar.dart';
import 'package:it_del/Screens/login_screen.dart';
import 'package:it_del/Services/IzinKeluar_service.dart';
import 'package:it_del/Services/globals.dart';
import 'package:it_del/Services/User_service.dart';
import 'package:intl/intl.dart';

class RequestIzinKeluarScreen extends StatefulWidget {
  const RequestIzinKeluarScreen({super.key});

  @override
  _RequestIzinKeluarScreenState createState() =>
      _RequestIzinKeluarScreenState();
}

class _RequestIzinKeluarScreenState extends State<RequestIzinKeluarScreen> {
  List<dynamic> _izinkeluarlist = [];
  int userId = 0;
  bool _loading = true;
  int _selectedIndex = 0;

  Future<void> retrievePosts() async {
    try {
      userId = await getUserId();
      ApiResponse response = await getIzinKeluar();

      if (response.error == null) {
        setState(() {
          _izinkeluarlist = response.data as List<dynamic>;
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

  void _navigateToAddData() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FormIzinKeluars(
              title: 'Request Izin Keluar',
            )));

    if (result != null && result) {
      retrievePosts();
    }
    Navigator.pop(context);
  }

  void deleteIzinKeluar(int id) async {
    try {
      ApiResponse response = await DeleteIzinKeluar(id);

      if (response.error == null) {
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() {
          _izinkeluarlist.removeWhere((item) => item.id == id);
        });
      } else if (response.error == unauthrorized) {
        // Handle unauthorized case if needed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    } catch (e) {
      print("Error in deleteIzinKeluar: $e");
    }
  }

  void onViewIzinKeluar(RequestIzinKeluar izinKeluar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Izin Keluar Details"),
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
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Izin Keluar'),
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
                label: const Text('Request Izin Keluar',
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
                      columnSpacing: 15,
                      headingRowColor: MaterialStateColor.resolveWith((states) {
                        return Colors.grey[300]!;
                      }),
                      columns: const [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Keperluan')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: _izinkeluarlist.map((bookingruangan) {
                        return DataRow(
                          color: MaterialStateColor.resolveWith((states) {
                            return _getColorForStatus(
                                bookingruangan.status ?? '');
                          }),
                          cells: [
                            DataCell(Text(
                                '${_izinkeluarlist.indexOf(bookingruangan) + 1}')),
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
                                      _izinkeluarlist.indexOf(bookingruangan);
                                  RequestIzinKeluar selectedIzinKeluar =
                                      _izinkeluarlist[index];

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FormIzinKeluars(
                                      title: "Edit Izin Keluar",
                                      formIzinKeluar: selectedIzinKeluar,
                                    ),
                                  ));
                                } else if (value == 'view') {
                                  onViewIzinKeluar(bookingruangan);
                                } else if (value == 'cancel') {
                                  deleteIzinKeluar(bookingruangan.id);
                                }
                              },
                              itemBuilder: (BuildContext context) {
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
        return Colors.red;
      case 'approved':
        return const Color.fromARGB(255, 100, 213, 104);
      default:
        return Colors.yellow;
    }
  }
}
