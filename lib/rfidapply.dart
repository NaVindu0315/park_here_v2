import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:park_here_v2/parkingslots.dart';
import 'package:park_here_v2/slot1payment.dart';

import 'dashboard.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() {}

class rfidapply extends StatefulWidget {
  @override
  State<rfidapply> createState() => _rfidapplyState();
}

class _rfidapplyState extends State<rfidapply> {
  final _firestore = FirebaseFirestore.instance;

  ///variables
  late String username;
  late String email;
  late String vnum;
  late String mobile;
  late String vtype;

  ///variables end
  ///ffunction to add
  Future<void> adddetails(
    String uname,
    String emaill,
    String vehnum,
    String phone,
    String vehtype,
  ) async {
    await FirebaseFirestore.instance.collection('rfid').doc(email).set({
      'username': uname,
      'email': emaill,
      'mobile': phone,
      'v number': vehnum,
      'vehicle type': vehtype,
    });
  }

  ///function to add end
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          /*actions: [

            ],*/
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => dashboard()),
              );
            },
          ),
          title: Text(
            '  Apply for a RFID card',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          backgroundColor: Color(0xFFFFD101),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      labelText: 'email',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  ///vehcile number
                  TextFormField(
                    onChanged: (value) {
                      vnum = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.car_crash_rounded,
                      ),
                      labelText: 'Vehicle Number',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  ///mobile
                  TextFormField(
                    onChanged: (value) {
                      mobile = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                      ),
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  ///vehicle type
                  TextFormField(
                    onChanged: (value) {
                      vtype = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.car_crash_outlined,
                      ),
                      labelText: 'Vehicle Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF19589D))),
                    onPressed: () {
                      adddetails(username, email, vnum, mobile, vtype);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Applied for RFID succesfully'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => dashboard()),
                                );
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );

                      //adduser(username, email, mobile, address, dob);
                    },
                    child: Text(
                      'Apply for RFID',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
