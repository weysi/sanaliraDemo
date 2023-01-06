import 'package:flutter/material.dart';

class Bank {
  String? bankName;
  String? bankIban;
  String? bankAccountName;
  String? descriptionNo;

  Bank(
      {this.bankName, this.bankIban, this.bankAccountName, this.descriptionNo});

  Bank.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    bankIban = json['bankIban'];
    bankAccountName = json['bankAccountName'];
    descriptionNo = json['descriptionNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['bankIban'] = this.bankIban;
    data['bankAccountName'] = this.bankAccountName;
    data['descriptionNo'] = this.descriptionNo;
    return data;
  }
}
