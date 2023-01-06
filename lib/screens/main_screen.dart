import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/bank_provider.dart';
import 'auth_screen.dart';
import '../widgets/bank_detail.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

  // Widget listBanks(BuildContext ctx) => FutureBuilder(
  //       future: Provider.of<BankProvider>(ctx, listen: false).getListBank(),
  //       builder: (ctx, snapShot) =>
  //           snapShot.connectionState == ConnectionState.waiting
  //               ? Center(
  //                   child: CircularProgressIndicator(),
  //                 )
  //               : Consumer<BankProvider>(
  //                   child: Center(child: Text('Not found a bank about that !')),
  //                   builder: (ctx, bank, ch) => bank.listBank.isEmpty
  //                       ? ch!
  //                       : SingleChildScrollView(
  //                           child: ListView.builder(
  //                             shrinkWrap: true,
  //                             padding: EdgeInsets.all(15),
  //                             itemCount: bank.listBank.length,
  //                             itemBuilder: (ctx, index) => ClipRect(
  //                               child: ListTile(
  //                                 leading: CircleAvatar(
  //                                   child: FlutterLogo(
  //                                     size: 30,
  //                                   ),
  //                                 ),
  //                                 title: Text(
  //                                   bank.listBank[index].bankName!,
  //                                   style: TextStyle(fontSize: 12),
  //                                 ),
  //                                 subtitle: Text("Havale / EFT ile gönderin "),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                 ),
  //     );
  var stream = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  Widget listBanks(BuildContext context) {
    return StreamBuilder(
      stream: stream
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('banks')
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var bankDoc = snapshot.data!.docs;
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(15),
              itemCount: bankDoc.length,
              itemBuilder: (ctx, index) => ClipRect(
                child: GestureDetector(
                  key: ValueKey('${index + 1}'),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => BackdropFilter(
                          filter: ImageFilter.blur(),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height / 2 + 125,
                            child: BankDetail(
                                bankIban: bankDoc[index]['bankIban'],
                                accountName: bankDoc[index]['bankAccountName'],
                                descriptionNo: bankDoc[index]['descriptionNo']),
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: FlutterLogo(
                          size: 30,
                        ),
                      ),
                      title: Text(
                        bankDoc[index]['bankName'],
                        style: TextStyle(fontSize: 12),
                      ),
                      subtitle: Text("Havale / EFT ile gönderin "),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 20, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    color: Colors.green,
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_alert),
                    color: Colors.green,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                    color: Colors.green,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: FlutterLogo(size: 30),
                title: Text("Türk Lirası"),
                subtitle: Text("TL"),
                trailing: Text(
                  "234TL",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Türk liarsı yatırmak için banka seçiniz",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              listBanks(context)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, color: Colors.green),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange, color: Colors.green),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.credit_card,
              color: Colors.green,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
