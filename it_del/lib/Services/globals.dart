import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String baseURL = "http://192.168.42.165:8000/api/";
const serverError = 'Server Error';
const unauthrorized = 'Unauthrorized';
const somethingWentWrong = 'Something Went Wrong Try Agian';
const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 1),
  ));
}
