import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:project/utils/styles.dart';

import 'addons.dart';
import 'firstpage.dart';
import 'registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  var _passwordVisible = false;
  void initState() {
    _passwordVisible = false;
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // title: Text("Login"),
            backgroundColor: Colors.teal,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.toNamed('/');
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2019/03/21/15/51/chatbot-4071274_960_720.jpg",
                // height: 250,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(23),
                  child: ListView(
                    shrinkWrap:
                        true, //you must add this if you place listview inside scrollview
                    physics:
                        NeverScrollableScrollPhysics(), //to prevent default scrolling of listview
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: _emailController,
                          style: inputstyle(),
                          decoration:
                              inputdec("Username", Icons.person_outline)),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: !_passwordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _passwordController,
                        style: inputstyle(),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: new BorderSide(color: Colors.cyan)),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 16, // or whatever
                              color: Colors.grey,
                              height:
                                  2.2, //                                <----- this was the key
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            hintText: "Password"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () async {
                            // print(_emailController.toString() +
                            //     " " +
                            //     _passwordController.toString());
                            try {
                              await _firebaseAuth
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) => print('Login Successful'));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FirstPage()));
                            } catch (e) {
                              String error;
                              error = e.toString();
                              int kpp = error.lastIndexOf(']') + 1;
                              toast(error.substring(kpp), context);
                            }
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Colors.cyan, //Color(0xffff2d55),
                          elevation: 0,
                          minWidth: 400,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New user ?",
                          ),
                          MaterialButton(
                              onPressed: () {
                                Get.toNamed("/register");
                              },
                              child: Text("Register now",
                                  style: TextStyle(
                                      color: Colors.red[800],
                                      fontSize: 18,
                                      decoration: TextDecoration.underline)))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ))),
    );
  }
}