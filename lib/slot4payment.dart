import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:park_here_v2/dashboard.dart';

import 'login.dart';

class slot4pay extends StatefulWidget {
  const slot4pay({Key? key}) : super(key: key);

  @override
  _slot4payState createState() => _slot4payState();
}

class _slot4payState extends State<slot4pay> {
  late DatabaseReference _databaseReference;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  String parkedseconds = '--';
  String cost = "";

  @override
  void initState() {
    super.initState();
    _databaseReference =
        FirebaseDatabase.instance.reference().child('Vehicle1/ParkingDuration');
    _databaseReference.onValue.listen((event) {
      setState(() {
        parkedseconds = event.snapshot.value.toString();
      });
    });

    _databaseReference =
        FirebaseDatabase.instance.reference().child('Vehicle1/ParkingCost');
    _databaseReference.onValue.listen((event) {
      setState(() {
        cost = event.snapshot.value.toString();
      });
    });

    /*  ///name
    _databaseReference = FirebaseDatabase.instance.reference().child('Hours');
    _databaseReference.onValue.listen((event) {
      setState(() {
        phrs = event.snapshot.value.toString();
      });
    });

    ///name end
    ///vnum
    _databaseReference = FirebaseDatabase.instance.reference().child('minutes');
    _databaseReference.onValue.listen((event) {
      setState(() {
        pmins = event.snapshot.value.toString();
      });
    });

    ///vnum end
    ///tempp
    _databaseReference = FirebaseDatabase.instance.reference().child('Fee');
    _databaseReference.onValue.listen((event) {
      setState(() {
        pfee = event.snapshot.value.toString();
      });
    });*/

    ///tempp end
  }

  ///to cost
  void update(double value) {
    _database.child('Vehicle1/ParkingCost').set(value);
  }

  ///cost end
  ///time
  void uptime(String value) {
    _database.child('Vehicle1/ParkingDuration').set(value);
  }

  ///time end
  ///

  void updateMotorValue(int value) {
    _database.child('motor/s1').set(value);
  }

  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD101),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Pay Now'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                ' SLOT 4',
                style: TextStyle(fontSize: 40),
              ),
            ),
            Text(
              ' Your vehicle has been parked in for',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              ' $parkedseconds seconds',
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 20),
            Text(
              'Your Fee is ',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              '\nRs.$cost',
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Payment Successful'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          update(0.0);
                          uptime("0.0");
                          updateMotorValue(1);
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
              },
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
