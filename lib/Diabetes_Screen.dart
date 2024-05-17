import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_application_1/Ok_Rsult_Screen.dart';
import 'package:flutter_application_1/Notok_Result_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'variables.dart';


class Diabetes extends StatefulWidget {
  const Diabetes({Key? key}) : super(key: key);

  @override
  _DiabetesState createState() => _DiabetesState();
}

class _DiabetesState extends State<Diabetes> {
  int? selectedHbA1c;
  int? selectedCholesterol;
  int? selectedTG;
  int? selectedBMI;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diabetes',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 38, 99),
        toolbarHeight: 75.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please describe any health symptoms you may feel related to diabetes!',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                _buildDropdownRow(
                  context,
                  hint2: 'Hemoglobin A1c',
                  hint1: 'Hemoglobin A1c level in the blood.',
                  label1: 'HBA1c',

                  onChanged: (value) {
                    setState(() {
                      selectedHbA1c = value;
                    });
                  },
                  options: ['<5.7	(normal)', '5.7-6.4	(prediabetes)', '>6.4	(diabetes)'],
                ),
                SizedBox(height: 8.0),
                _buildDropdownRow(
                  context,
                  hint2: 'Cholesterol',
                  hint1: 'Total cholesterol level in the blood.',
                  label1: 'chol',
                  onChanged: (value) {
                    setState(() {
                      selectedCholesterol = value;
                    });
                  },
                  options: ['<200	(desirable)', '200-239	(borderline high)', '>239	(high)'],
                ),
                SizedBox(height: 8.0),
                _buildDropdownRow(
                  context,
                  hint2: 'Triglycerides',
                  hint1: 'The level of triglycerides in the blood.',
                  label1: 'TG',
                  onChanged: (value) {
                    setState(() {
                      selectedTG = value;
                    });
                  },
                  options: ['<150 ', '150-199 ', '200-400', '>500 '],
                ),
                SizedBox(height: 8.0),
                _buildDropdownRow(
                  context,
                  hint2: 'Body Mass Index',
                  hint1: ' Body Mass Index, enter the correct numerical value..',
                  label1: 'BMI',
                  onChanged: (value) {
                    setState(() {
                      selectedBMI = value;
                    });
                  },
                  options: ['<18.5 underweight', '18-25 normal', ' 25-30 overweight', '>30 obese'],
                ),
                SizedBox(height: 10.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _getStatus();
                    },
                    child: Text(
                      'Get Status',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 2, 38, 99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownRow(BuildContext context,
      {required String label1,
        required String hint1,
        required String hint2,
        required List<String> options,
        required Function(int) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('$label1'),
                  content: Text(hint1),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Exit'),
                    ),
                  ],
                );
              },
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.grey,
              ),
              SizedBox(width: 8.0),
              Text(
                label1,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: null,
          items: options.asMap().entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key.toString(),
              child: Text(entry.value),
            );
          }).toList(),
          onChanged: (newValue) {
            onChanged(int.parse(newValue!));
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: hint2,
            helperText: null,
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Future<void> _getStatus() async {
    print('getstatus clicked');
    // Check if any dropdown has null selected value
    if (selectedHbA1c == null || selectedCholesterol == null || selectedTG == null || selectedBMI == null) {
      // Display a small modern alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select values for all dropdowns.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // All dropdowns have selected values, proceed with API call
    final Map<String, dynamic> requestBody = {
      'HbA1c': selectedHbA1c,
      'Chol': selectedCholesterol,
      'TG': selectedTG,
      'BMI': selectedBMI
    };



    try {
      // Sending request to the liver prediction API
      final response = await http.post(
        Uri.parse('https://10.0.2.2:3000/flask/diabetes_predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Success, handle the response
        print('diabetes status: ${response.body}');
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        dynamic prediction = responseBody['prediction'][0];
        // Display result to user
        if (prediction == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OkScreen()),
          );
        } else if (prediction == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotOkScreen()),
          );
        }
      } else {
        // Request failed
        print('Failed with status code ${response.statusCode}');
        // Display error to user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to get liver status. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('error : ${e.toString()}');
    }
  }
}
