import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/user.dart';
import 'package:it_del/Services/User_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rounded_button.dart';
import '../Mahasiswa.screen/MahasiswaScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtnomorktp = TextEditingController();
  TextEditingController txtnomorhandphone = TextEditingController();
  TextEditingController txtnim = TextEditingController();

  createAccountPressed() async {
    ApiResponse response = await register(
      txtname.text,
      txtnomorktp.text,
      txtnomorhandphone.text,
      txtnim.text,
      txtemail.text,
      txtpassword.text,
    );
    if (response.error == null) {
      // Extract the role from the response
      _saveAndRedirectHome(response.data as User);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _saveAndRedirectHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MahasiswaScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Register',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Add the logo here
            Image.asset(
              'assets/logo.jpg', // Change 'your_logo.png' to the actual asset path
              height: 100, // Adjust the height as needed
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: txtname,
              validator: (val) =>
                  val!.isEmpty ? 'Nama Tidak Boleh Kosong' : null,
              decoration: const InputDecoration(
                labelText: 'Nama',
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: txtnim,
              validator: (val) =>
                  val!.isEmpty ? 'Nim tidak boleh kosong' : null,
              decoration: const InputDecoration(
                labelText: 'NIM',
                hintText: 'Enter your NIM',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: txtnomorhandphone,
              validator: (val) =>
                  val!.isEmpty ? 'Nomor Handphone tidak boleh kosong' : null,
              decoration: const InputDecoration(
                labelText: 'Nomor Handphone',
                hintText: 'Enter your Number Phone',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: txtnomorktp,
              validator: (val) =>
                  val!.isEmpty ? 'Nomor Ktp tidak boleh kosong' : null,
              decoration: const InputDecoration(
                labelText: 'Nomor KTP',
                hintText: 'Enter your Number KTP',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: txtemail,
              validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: txtpassword,
              obscureText: true,
              validator: (val) =>
                  val!.length < 6 ? 'Membutuh setidaknya 6 huruf' : null,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 8,
            ),
            RoundedButton(
              btnText: 'Register',
              onBtnPressed: () => createAccountPressed(),
            )
          ],
        ),
      ),
    );
  }
}
