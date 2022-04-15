import 'dart:convert';

import 'package:crypto_app/constants/constants.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future getCryptoCurrency() async {
  Uri url = Uri.parse(cryptoDomain);
  final response = await http.get(url);
  // debugPrint('==============================================================');
  // debugPrint(response.body);
  // debugPrint('==============================================================');
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception(' An Error occured');
  }
}
