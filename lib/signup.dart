import 'package:flutter/material.dart';

//import 'package:registerandlogin/userdetails.dart';
import 'login.dart';
import 'main.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(sign());
}

class sign extends StatefulWidget {
  static String id = 'loginscreen';

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  void createuser() async {
    try {
      final newuser = await _auth.createUserWithEmailAndPassword(
          email: email, password: pw);

      ///call the add details function here

      if (newuser != null) {
        Navigator.pushNamed(context, sign.id);
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController pwcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;
  late String email;
  late String pw;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFFD101),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFD101),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
          title: const Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 24),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'Try ', // Add this new Text widget
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F3D56),
                        ),
                      ),
                    ),
                    SizedBox(height: 5), // Add this SizedBox widget
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3F3D56),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      height: 70,
                      width: 350, // Set the width of the SizedBox to 300 pixels
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: emailcontroller,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 70,
                      width: 350, // Set the width of the SizedBox to 300 pixels
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: pwcontroller,
                          onChanged: (value) {
                            pw = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.key,
                            ),
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD101),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "already signed up ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => lgin()),
                              );
                              //  Navigator.pushNamed(context, gemifysign.id);
                              // Add your sign up button onPressed code here
                            },
                            child: Text(
                              'login ',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                //decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            " Now ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 350,
                        height: 50,
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            emailcontroller.clear();
                            pwcontroller.clear();
                            try {
                              createuser();
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => lgin()),
                              );*/
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //to add social media icons
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
