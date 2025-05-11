import 'package:flutter/material.dart';

class GpaCalculator extends StatefulWidget {
  @override
  _GpaCalculatorState createState() => _GpaCalculatorState();
}

class _GpaCalculatorState extends State<GpaCalculator> {
  // Controllers
  final _formKey = GlobalKey<FormState>();
  TextEditingController _courseNameController = TextEditingController();
  TextEditingController _marksController = TextEditingController();
  TextEditingController _creditsController = TextEditingController();
  TextEditingController _totalCreditsController = TextEditingController();
  TextEditingController _totalPointsController = TextEditingController();
  TextEditingController _gpaController = TextEditingController();
  TextEditingController _toDisplayController = TextEditingController();

  int _totalCredits = 0;
  double _totalPoints = 0;
  double _gpa = 0;
  // Navigation Methods

  // Update your calculateGPA method to this:
  String calculateGPA() {
    if (_formKey.currentState!.validate()) {
      final marks = int.parse(_marksController.text);
      final credits = int.parse(_creditsController.text);

      late double points;
      if (marks >= 80) {
        points = 4.0;
      } else if (marks >= 65) {
        points = 3.0;
      } else if (marks >= 55) {
        points = 2.0;
      } else if (marks >= 50) {
        points = 1.0;
      } else {
        points = 0.0;
      }

      // Update totals
      _totalCredits += credits;
      _totalPoints += (credits * points);
      _gpa = (_totalPoints / _totalCredits);

      return 'Total Credits: $_totalCredits\nTotal Points: $_totalPoints\nGPA: ${_gpa.toStringAsFixed(2)}';
    }
    return 'Invalid input';
  }

  // Update your _addCourse method to this:
  void _addCourse() {
    if (_formKey.currentState!.validate()) {
      String toShow = calculateGPA();
      setState(() {
        _toDisplayController.text = toShow;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Input Decoration Style
  InputDecoration _buildInputDecoration(
    String label,
    String hint, {
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
      hintStyle: TextStyle(color: Colors.white70),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.amber),
        borderRadius: BorderRadius.circular(10.0),
      ),
      suffixIcon: icon != null ? Icon(icon, color: Colors.amber[200]) : null,
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        toolbarHeight: 50, // Set your desired height (default is 56)
        title: Text(
          'GPA Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber[200],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5), // Only 20px space after AppBar
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Course Name Field
                    TextFormField(
                      controller: _courseNameController,
                      style: TextStyle(
                        color: Colors.amber[200],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: _buildInputDecoration(
                        'Course Name',
                        'Enter course name',
                        icon: Icons.school,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    SizedBox(height: 7.5),

                    // Marks Field
                    TextFormField(
                      controller: _marksController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.amber[200],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: _buildInputDecoration(
                        'Marks (0-100)',
                        'Enter marks between 0-100',
                        icon: Icons.score,
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
                    SizedBox(height: 7.5),

                    // Credits Field
                    TextFormField(
                      controller: _creditsController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.amber[200],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: _buildInputDecoration(
                        'Credits',
                        'Enter credit hours',
                        icon: Icons.numbers,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        final credits = int.tryParse(value);
                        if (credits == null || credits <= 0) {
                          return 'Invalid credits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 7.5),

                    // Add Course Button - now full width
                    SizedBox(
                      width: double.infinity, // Makes button full width
                      child: ElevatedButton(
                        onPressed: _addCourse,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15, // Keep vertical padding
                          ),
                        ),
                        child: Text(
                          'Add Course',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                _toDisplayController.text,
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
    );
  }

  @override
  void dispose() {
    _totalCreditsController.dispose();
    _totalPointsController.dispose();
    _courseNameController.dispose();
    _marksController.dispose();
    _creditsController.dispose();
    super.dispose();
  }
}
