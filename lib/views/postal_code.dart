import 'package:flutter/material.dart';

class PostalCode extends StatefulWidget {
  @override
  _PostalCodeState createState() => _PostalCodeState();
}

class _PostalCodeState extends State<PostalCode> {
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _postalCode = TextEditingController();

  String _postalCodeDetector(String postCode) {
    late String to_return;

    Map<String, String> postalCode = {
      // Provinces
      "A": "Newfoundland and Labrador",
      "B": "Nova Scotia",
      "C": "Prince Edward Island",
      "E": "New Brunswick",
      "G": "Quebec (Eastern)",
      "H": "Quebec (Metropolitan Montreal)",
      "J": "Quebec (Western)",
      "K": "Ontario (Eastern)",
      "L": "Ontario (Central)",
      "M": "Ontario (Metropolitan Toronto)",
      "N": "Ontario (Southwestern)",
      "P": "Ontario (Northern)",
      "R": "Manitoba",
      "S": "Saskatchewan",
      "T": "Alberta",
      "V": "British Columbia (Metropolitan Vancouver)",

      // Territories
      "X": "Northwest Territories/Nunavut", // Shared prefix
      "Y": "Yukon",
    };

    String firstLetter = postCode[0];
    String secondLetter = postCode[1];

    String territoryType = int.parse(secondLetter) == 1 ? "Urban" : "Rural";

    to_return =
        "Province/Territory : ${postalCode[firstLetter]}\n"
        "Type : $territoryType";

    return to_return;
  }

  void onPressedAnalyze() {
    String postalCode = _postalCodeController.text;
    if (postalCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a postal code'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      _postalCode.text = _postalCodeDetector(postalCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text(
          'Postal Code Analyzer',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber[200],
          ),
        ),

        centerTitle: true,
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
                  TextFormField(
                    controller: _postalCodeController,
                    style: TextStyle(
                      color: Colors.amber[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.location_on,
                        color: Colors.amber[200],
                      ), // Right side icon
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
                      labelText: 'Enter Postal Code',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      hintText: 'A1B2C3',
                      hintStyle: TextStyle(color: Colors.white70),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      final marks = int.tryParse(value);
                      if (marks == null || marks < 0 || marks > 100) {
                        return 'Enter 0-100';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onPressedAnalyze,
                    child: Text('Analyze'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _postalCode.text,
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
