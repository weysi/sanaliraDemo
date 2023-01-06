import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sanal_lira/screens/main_screen.dart';
import '../providers/bank_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  void dispose() {
    super.dispose();
  }

  var _formKey = GlobalKey<FormState>();
  var name = '';
  var surname = '';
  var email = '';
  var phoneNumber;
  var password = '';
  bool _isLoading = false;
  bool _isLogin = false;
  bool kvvk = false;
  Map<String, dynamic> user = {
    "name": null,
    "surname": null,
    "email": null,
    "phoneNumber": null,
    "password": null,
    "userID": null,
  };
  void submitForm(BuildContext context) async {
    var validate = _formKey.currentState!.validate();
    if (!kvvk) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Lütfen kvvk kuralları okuyup onaylanıyız...",
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      if (validate) {
        _formKey.currentState!.save();

        user["name"] = name;
        user["surname"] = surname;
        user["email"] = email;
        user["phoneNumber"] = phoneNumber;
        user["password"] = password;

        UserCredential auth;
        if (_isLogin) {
          auth = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
        } else {
          auth = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(auth.user!.uid)
              .set(user);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("A Error found that is  ${e.toString()} "),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var pageSize = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white.withOpacity(.25)),
      // color: Colors.white.withOpacity(.45),
      margin: EdgeInsets.only(top: pageSize.height / 2 - 100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "SanaLira'ya",
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Yeni Üyelik",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Bilgilerinizi girip sözleşmeyi onaylayın.',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              if (!_isLogin)
                //Name
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  key: ValueKey("name"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.length < 3 && value.length > 50) {
                      return "Lütfen en az 3 karakterli isim giriniz.";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                  decoration: InputDecoration(
                    hintText: "Lütfen İsminizi Giriniz ...",
                    hintStyle: const TextStyle(color: Colors.white),
                    label: Text("Ad"),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              //Surname
              if (!_isLogin)
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.length < 3 ||
                        value.length > 50) {
                      return "Lütfen en az 3 karakter giriniz...";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    surname = value!;
                  },
                  decoration: InputDecoration(
                    hintText: "Lütfen Soyadınız giriniz...",
                    hintStyle: const TextStyle(color: Colors.white),
                    label: Text("Soyad"),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              //Eposta

              TextFormField(
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!value!.contains('@')) {
                    return "Lütfen emailinizi kontrol ediniz";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  email = value!;
                },
                decoration: InputDecoration(
                  hintText: "Lütfen Epostanızı giriniz...",
                  hintStyle: const TextStyle(color: Colors.white),
                  label: Text("E-Posta"),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //Password
              TextFormField(
                style: const TextStyle(color: Colors.white),
                key: ValueKey("password"),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  RegExp regex = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');
                  if (value!.isEmpty) {
                    return 'Lütfen Şifrenizi giriniz';
                  } else {
                    if (!regex.hasMatch(value)) {
                      return 'Geçerli bir şifre giriniz...';
                    } else {
                      return null;
                    }
                  }
                },
                onSaved: (value) {
                  password = value!;
                },
                decoration: InputDecoration(
                  hintText: "Lütfen şifrenizi giriniz...",
                  hintStyle: const TextStyle(color: Colors.white),
                  label: Text("Şifre"),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              if (!_isLogin)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlutterLogo(),
                            Text(
                              "+90",
                              style: TextStyle(color: Colors.white),
                            )
                          ]),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    //Phone Number
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          phoneNumber = value!;
                        },
                        validator: (value) {
                          if (value!.length < 6 && value.length > 20) {
                            return "Lütfen geçerli bir şifre giniz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text("Telefon"),
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 15,
              ),

              if (!_isLogin)
                Row(children: [
                  Checkbox(
                      value: kvvk,
                      onChanged: (value) {
                        setState(() {
                          kvvk = value!;
                        });
                        print(kvvk);
                      },
                      activeColor: Colors.green,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.white;
                        }
                        return Colors.green;
                      })),
                  Expanded(
                    child: Text(
                      "Hesabınızı oluştururken sözleşme ve koşulları kabul etmeniz gerekir.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),

              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        kvvk = true;
                      });
                      submitForm(context);
                    },
                    child:
                        Text(_isLogin ? "SIGN-IN" : "Create New User Account"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
