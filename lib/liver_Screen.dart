import 'dart:convert';
import 'package:flutter_application_1/Notok_Result_Screen.dart';
import 'package:flutter_application_1/Ok_Rsult_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LiverScreen extends StatefulWidget {
  const LiverScreen({Key? key}) : super(key: key);

  @override
  _LiverScreenState createState() => _LiverScreenState();
}

class _LiverScreenState extends State<LiverScreen> {
  // Variables to hold selected values
  int? ageIndex;
  int? genderIndex;
  int? totalBilirubinIndex;
  int? directBilirubinIndex;
  int? alkPhosIndex;
  int? alatIndex;
  int? asatIndex;
  int? totalProteinsIndex;
  int? albuminIndex;
  int? albGlobRatioIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liver Disease',
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
                  'Please describe symptoms you may feel related to diabetes Disease!',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                _buildDropdownRow(
                  context,
                  label1: 'Age',
                  hint1: 'Age, enter age in years.',
                  hint2: 'Age',
                  options: [
                    '18-45  young adult',
                    '46-60  adult',
                    '61- n  senior adult'
                  ],
                  onChanged: (value) {
                    setState(() {
                      ageIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'Gender',
                  hint1: 'gender, enter the gender (male/female).',
                  hint2: 'Gender',
                  options: [
                    'male',
                    'female',
                  ],
                  onChanged: (value) {
                    setState(() {
                      genderIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'Total Bilirubin',
                  hint1:
                  'Total bilirubin in the blood. Enter the value in the appropriate unit such as (mg/dL).',
                  hint2: 'Total Bilirubin ',
                  options: [
                    '0.5 - 1.2 (normal) ',
                    '1.3-2 (elevated)',
                    '>2 (high	)',
                  ],
                  onChanged: (value) {
                    setState(() {
                      totalBilirubinIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'Direct Bilirubin',
                  hint1:
                  'Direct bilirubin in the blood, enter the value in the appropriate unit such as (mg/dL).',
                  hint2: 'Direct Bilirubin',
                  options: [
                    '0.1 - 0.3 (normal) ',
                    '0.4-0.5 (elevated)',
                    '>0.5 (high)'
                  ],
                  onChanged: (value) {
                    setState(() {
                      directBilirubinIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'Alk Phos',
                  hint1:
                  'Alkaline phosphatase, enter the value in the appropriate unit such as (U/L).',
                  hint2: ' Alk Phos',
                  options: [
                    '75-125 (normal)',
                    '125-299 (elevated)',
                    '>299 (high)'
                  ],
                  onChanged: (value) {
                    setState(() {
                      alkPhosIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'ALAT',
                  hint1:
                  'alanine aminotransferase, enter the value in the appropriate unit such as (U/L).',
                  hint2: 'ALAT',
                  options: [
                    '10-40 (normal )',
                    '40-150 (elevated	)',
                    '>150 (high)'
                  ],
                  onChanged: (value) {
                    setState(() {
                      alatIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'ASAT ',
                  hint1:
                  'aspartate aminotransferase, enter the value in the appropriate unit such as (U/L).',
                  hint2: 'ASAT',
                  options: ['10 - 40 (Normal)',
                   ' 41 - 200 (Elevated)',
                    '200> (High)',],
                  onChanged: (value) {
                    setState(() {
                      asatIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'Total Proteins',
                  hint1:
                  'Total proteins in the blood. Enter the value in the appropriate unit such as (g/dL).',
                  hint2: 'Total Prot',
                  options: [
                    '6-8.3 (normal)',
                    '6-6.3 (low)',
                    '>6.3 (borderline low)'
                  ],
                  onChanged: (value) {
                    setState(() {
                      totalProteinsIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'Albumin',
                  hint1:
                  ' albumin, enter the value in the appropriate unit such as (g/dL).',
                  hint2: 'Alb',
                  options: [
                    '3.5-5.5 (normal)',
                    '3.5-3.5 (low)',
                    '<2.5 (very low)'
                  ],
                  onChanged: (value) {
                    setState(() {
                      albuminIndex = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(
                  context,
                  label1: 'Alb/Glob Ratio',
                  hint1:
                  ' The ratio of albumin to globulin in the blood. Enter the ratio as required.',
                  hint2: 'Alb/Glob Ratio',
                  options: [
                    '<0.5 (very low)',
                    '0.5-1 (low)',
                    '1-1.8 (normal)',
                    '>1.8 (high)'
                  ],
                  onChanged: (value) {
                    setState(() {
                      albGlobRatioIndex = value;
                    });
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _getStatus();
                      print( ageIndex);
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
  // int? ageIndex;
  // int? genderIndex;
  // int? totalBilirubinIndex;
  // int? directBilirubinIndex;
  // int? alkPhosIndex;
  // int? alatIndex;
  // int? asatIndex;
  // int? totalProteinsIndex;
  // int? albuminIndex;
  // int? albGlobRatioIndex;

  Future<void> _getStatus() async {
    if (ageIndex == null || genderIndex == null || totalBilirubinIndex == null || directBilirubinIndex == null||alkPhosIndex== null||alatIndex==null||asatIndex==null||totalProteinsIndex==null||albuminIndex==null||albGlobRatioIndex==null) {
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

    // Constructing request body
    final Map<String, dynamic> requestBody = {
      'age': ageIndex,
      'gender2': genderIndex,
      'Total_Bilirubin': totalBilirubinIndex,
      'Direct_Bilirubin': directBilirubinIndex,
      'Alkaline_Phosphotase': alkPhosIndex,
      'Alamine_Aminotransferase': alatIndex,
      'Aspartate_Aminotransferase': asatIndex,
      'Total_Protiens': totalProteinsIndex,
      'Albumin': albuminIndex,
      'Albumin_and_Globulin_Ratio': albGlobRatioIndex,
    };


    try
    {


    // Sending request to the liver prediction API
    final response = await http.post(
      Uri.parse('https://10.0.2.2:3000/flask/liver_predict'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Success, handle the response
      print('Liver status: ${response.body}');
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      dynamic prediction = responseBody['prediction'][0];
      // Display result to user
      if(prediction==0){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OkScreen()),
        );
      }
      else if(prediction==1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotOkScreen()),
        );
      }
    } else {
      // Request failed
      print("response: ${response.body}");
      print('Failed with status code ${response.statusCode}');
      print("response: ${response.body}");
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
    }
    catch(e)
    {
      print('error : ${e.toString()}');
    }
  }
}
