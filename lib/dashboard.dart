import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:park_here_v2/parkingslots.dart';
import 'package:park_here_v2/rfidapply.dart';
import 'package:park_here_v2/slot1payment.dart';

void main() {
  runApp(dashboard());
}

///statless widget
class dashboard extends StatelessWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: rsv(),
    );
  }
}

///statfull widget

class rsv extends StatefulWidget {
  @override
  State<rsv> createState() => _rsvState();
}

class _rsvState extends State<rsv> {
  late DatabaseReference pglink;
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

  String pgadrs = 'google.com';
  int avlslots = 0;
  int avls = 4;
  @override
  void initState() {
    super.initState();

    ///name
    pglink = FirebaseDatabase.instance.reference().child('page');
    pglink.onValue.listen((event) {
      setState(() {
        pgadrs = event.snapshot.value.toString();
      });
    });

    ///sensor1
    _databaseReference =
        FirebaseDatabase.instance.reference().child('Sensors/sensor1');
    _databaseReference.onValue.listen((event) {
      setState(() {
        sen1 = event.snapshot.value.toString();
        s1 = int.parse(sen1);
        if (s1 == 1) {
          avls--;
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
          avls--;
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
          avls--;
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
          avls--;
          s4avl = "Parked";
        } else if (s4 == 0) {
          s4avl = "free";
        }
      });
    });
    print((s1 + s2 + s3 + s4));
    avlslots = 4 - (s1 + s2 + s3 + s4);

    ///snesor 4 end
  }

  int tot = 4;

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
            '         Park Here',
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendDataPage()),
                        );*/
                      },
                      child: Image.asset('images/cvr.png'),
                    ),
                  )
                ],
              ),

              ///available
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
                          labelText: "Total slots",
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
                          labelText: "4",
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
                          labelText: "Available Slots",
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
                          labelText: avls.toString(),
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

              ///avialble end

              ////first two images
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      ///to park now ir page
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => parkingslots()),
                        );
                      },
                      child: Image.asset('images/prk.png'),
                    ),
                  ),
                  ////second image
                  Expanded(
                    child: TextButton(
                      ///to  view the vehicle
                      onPressed: () {
                        /*   Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => bk()),
                        );*/
                      },
                      child: Image.asset('images/cam.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              ////second image row
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      ///rfid
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => rfidapply()),
                        );
                      },
                      child: Image.asset('images/rfid.png'),
                    ),
                  ),
                  ////second image
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pypage()),
                        );*/
                      },
                      child: Image.asset('images/4.png'),
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
