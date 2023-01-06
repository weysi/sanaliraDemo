import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'screens/auth_screen.dart';
import './screens/main_screen.dart';
import './providers/bank_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: BankProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sanalira Demo Project',
          theme: ThemeData(
              primaryColor: Colors.green,
              bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  )),
              buttonTheme: ButtonThemeData(
                  buttonColor: Colors.green[100],
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Colors.green,
                  ))),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return MainScreen();
              }
              return AuthScreen();
            }),
          ),
          routes: {
            MainScreen.routeName: (ctx) => MainScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          }),
    );
  }
}
