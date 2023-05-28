import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:park_here_v2/dashboard.dart';
import 'package:park_here_v2/slot1payment.dart';
import 'package:park_here_v2/slot2payment.dart';
import 'package:park_here_v2/slot3payment.dart';
import 'package:park_here_v2/slot4payment.dart';

void main() {}

class parkingslots extends StatelessWidget {
  const parkingslots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookingScreen(),
    );
  }
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  late DatabaseReference _databaseReference;

  late DatabaseReference motor2;

  int slot = 0;
  String humidity = "0";
  double time = 12.1;
  String temp = "27";
  String sen1 = "0";
  String sen2 = "0";
  String sen3 = "0";
  String sen4 = "0";
  int s1 = 0;
  int s2 = 0;
  int s3 = 0;
  int s4 = 0;

  String s1avl = "free";
  String s2avl = "parked";
  String s3avl = "free";
  String s4avl = "free";
  @override
  void initState() {
    super.initState();

    ///for the motor
    motor2 = FirebaseDatabase.instance.ref().child('test/data');
    //motor2 = FirebaseDatabase.instance.reference().child('motor');

    ///motor end

    ///temperature
    _databaseReference =
        FirebaseDatabase.instance.reference().child('DHT/temperature');
    _databaseReference.onValue.listen((event) {
      setState(() {
        temp = event.snapshot.value.toString();
      });
    });

    ///temperature end
    ///humidity
    _databaseReference =
        FirebaseDatabase.instance.reference().child('DHT/humidity');
    _databaseReference.onValue.listen((event) {
      setState(() {
        humidity = event.snapshot.value.toString();
      });
    });

    ///humidity end
    ///sensor1
    _databaseReference =
        FirebaseDatabase.instance.reference().child('Sensors/sensor1');
    _databaseReference.onValue.listen((event) {
      setState(() {
        sen1 = event.snapshot.value.toString();
        s1 = int.parse(sen1);
        if (s1 == 1) {
          s1avl = "Parked";
        } else if (s1 == 0) {
          s1avl = "free";
        }
      });
    });

    ///sensor 1 end
    ///sensor2
    _databaseReference =
        FirebaseDatabase.instance.reference().child('Sensors/sensor2');
    _databaseReference.onValue.listen((event) {
      setState(() {
        sen2 = event.snapshot.value.toString();
        s2 = int.parse(sen2);
        if (s2 == 1) {
          s2avl = "Parked";
        } else if (s2 == 0) {
          s2avl = "free";
        }
      });
    });

    ///sensor2 end
    ///sensor3
    _databaseReference =
        FirebaseDatabase.instance.reference().child('Sensors/sensor3');
    _databaseReference.onValue.listen((event) {
      setState(() {
        sen3 = event.snapshot.value.toString();
        s3 = int.parse(sen3);
        if (s3 == 1) {
          s3avl = "Parked";
        } else if (s3 == 0) {
          s3avl = "free";
        }
      });
    });

    ///sensor 3 end
    ///sensor 4
    _databaseReference =
        FirebaseDatabase.instance.reference().child('Sensors/sensor4');
    _databaseReference.onValue.listen((event) {
      setState(() {
        sen4 = event.snapshot.value.toString();
        s4 = int.parse(sen4);
        if (s4 == 1) {
          s4avl = "Parked";
        } else if (s4 == 0) {
          s4avl = "free";
        }
      });
    });

    ///snesor 4 end
  }

  ///to set the motor value 1
  Future<void> motor1(String num) async {
    await motor2.set(num);
  }

  ///function end
  ///another chtgpt functionn
  void updateMotorValue(int value) {
    _database.child('motor/s1').set(value);
  }

  ///chatgpt function end

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Parking',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFFD101),
          leading: IconButton(
            icon: Image.asset(
              'assets/arrow.png',
              height: 30.0,
              width: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => dashboard()),
              );
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ///for temperature
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2, // Set the width of the SizedBox to 300 pixels
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        enabled: false,
                        readOnly: true,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.thermostat,
                          ),
                          labelText: "Temperature",
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    // Set the width of the SizedBox to 300 pixels
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        enabled: false,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.heat_pump,
                          ),
                          labelText: temp,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///end temp
              ///humidity
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2, // Set the width of the SizedBox to 300 pixels
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        enabled: false,
                        readOnly: true,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.thermostat,
                          ),
                          labelText: "humidity",
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    // Set the width of the SizedBox to 300 pixels
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        enabled: false,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.heat_pump,
                          ),
                          labelText: humidity,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///humidty end
              Row(
                children: <Widget>[
                  ///first slot
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/sport-car.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'slot 1\n'
                            'Status:$s4avl',
                            style: TextStyle(fontSize: 24.0),
                          ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => slot1pay()),
                              );
                            },
                            child: Text('pay'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///second slot
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/sport-car.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'slot 2\n'
                            'Status:$s3avl',
                            style: TextStyle(fontSize: 24.0),
                          ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => slot2pay()),
                              );
                            },
                            child: Text('pay'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  ///first slot
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/sport-car.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'slot 3\n'
                            'Status:$s2avl',
                            style: TextStyle(fontSize: 24.0),
                          ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => slot3pay()),
                              );
                            },
                            child: Text('pay'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///second slot
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/sport-car.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'slot 4\n'
                            'Status:$s1avl',
                            style: TextStyle(fontSize: 24.0),
                          ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => slot4pay()),
                              );
                            },
                            child: Text('pay'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        updateMotorValue(1);
                        //motor1("1");
                      },
                      child: Text(
                        'Open  Main Gate',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD101),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
