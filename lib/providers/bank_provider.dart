import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/bank.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BankProvider with ChangeNotifier {
  List<Bank> _listBank = [];
  List<Bank> get listBank {
    return [..._listBank];
  }

  Future<void> getListBank() async {
    var url = Uri.parse('https://api.sanalira.com/assignment');
    List<Bank> lst = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        var accounts = json.decode(response.body) as Map<String, dynamic>;

        accounts.forEach(
          ((key, value) {
            if (key == "data") {
              for (var item in value) {
                lst.add(Bank.fromJson(item));
              }
            }
          }),
        );
        print(lst[0].bankName);
        _listBank = lst;

        notifyListeners();
        //print(accounts["data"]);
      } catch (e) {}
    }
  }
}
