import 'package:flutter/material.dart';

class ZooAdmission extends StatefulWidget {
  @override
  _ZooAdmissionState createState() => _ZooAdmissionState();
}

class _ZooAdmissionState extends State<ZooAdmission> {
  TextEditingController _customerName = TextEditingController();
  TextEditingController _customerAge = TextEditingController();
  TextEditingController _toShow = TextEditingController();
  int _totalCost = 0;
  int _totalTickets = 0;

  void _customerDetails() {
    String name = _customerName.text;
    String age = _customerAge.text;
    _totalTickets += 1;

    if (name.isEmpty || age.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (int.tryParse(age) == null || int.parse(age) < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid age'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (int.parse(_customerAge.text) <= 10) {
      _totalCost += 10;
    } else if (int.parse(_customerAge.text) > 65) {
      _totalCost += 15;
    } else {
      _totalCost += 25;
    }

    setState(() {
      _toShow.text =
          "Last Customer Details:\n"
          "Customer Name: $name\n"
          "Customer Age: $age"
          "\nTotal Cost: $_totalCost\n"
          "Total Tickets: $_totalTickets";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text(
          'Zoo Admission Price',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber[200],
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _customerName,
                    style: TextStyle(
                      color: Colors.amber[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Enter Customer name',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.white70),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _customerAge,
                    style: TextStyle(
                      color: Colors.amber[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Enter Customer Age',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      hintText: 'Age',
                      hintStyle: TextStyle(color: Colors.white70),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    onPressed: _customerDetails,
                    child: Text(
                      'Add Customer',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _toShow.text,
                    style: TextStyle(
                      color: Colors.amber[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
