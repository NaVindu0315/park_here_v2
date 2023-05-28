import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:park_here_v2/dashboard.dart';

import 'main.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(lgin());
}

class lgin extends StatelessWidget {
  const lgin({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Smart Park'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController pwcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String email;
  late String pw;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFD101),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
          title: const Text(
            'Login',
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
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/pic_1.png'),
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 14),
                  alignment: Alignment.center,
                  child: Container(
                    width: 380,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFD101),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                          width:
                              350, // Set the width of the SizedBox to 300 pixels
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
                          width:
                              350, // Set the width of the SizedBox to 300 pixels
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
                                "didnt sign up yet? ",
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
                                    MaterialPageRoute(
                                        builder: (context) => sign()),
                                  );
                                  //  Navigator.pushNamed(context, gemifysign.id);
                                  // Add your sign up button onPressed code here
                                },
                                child: Text(
                                  'sign up ',
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: ElevatedButton(
                              onPressed: () async {
                                emailcontroller.clear();
                                pwcontroller.clear();
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: pw);

                                  if (user != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => dashboard()),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
