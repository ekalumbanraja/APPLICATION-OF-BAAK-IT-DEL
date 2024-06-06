import 'package:flutter/material.dart';
import 'package:it_del/Baak.screen/BaakScreen.dart';
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/user.dart';
import 'package:it_del/Services/User_service.dart';
import 'package:it_del/rounded_button.dart';
import 'package:it_del/Mahasiswa.screen/MahasiswaScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtemail.text, txtpassword.text);
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

    // Check the user's role and redirect accordingly
    if (user.role == 'mahasiswa') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MahasiswaScreen()),
        (route) => false,
      );
    } else if (user.role == 'baak') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const BaakScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Login',
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
              keyboardType: TextInputType.emailAddress,
              controller: txtemail,
              validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(
              height: 30,
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
              height: 30,
            ),
            const SizedBox(
              height: 30,
            ),
            RoundedButton(
              btnText: 'LOG IN',
              onBtnPressed: () => _loginUser(),
            ),
          ],
        ),
      ),
    );
  }
}
