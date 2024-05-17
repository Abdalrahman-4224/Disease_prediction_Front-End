import 'dart:convert';
import 'package:flutter_application_1/Notok_Result_Screen.dart';
import 'package:flutter_application_1/Ok_Rsult_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Kidney extends StatefulWidget {
  const Kidney({Key? key}) : super(key: key);

  @override
  _KidneyState createState() => _KidneyState();
}

class _KidneyState extends State<Kidney> {
  // Define variables to hold the selected values
  int? sgValue;
  int? albValue;
  int? hemoValue;
  int? pcvValue;
  int? rcValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kidney Disease',
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
                  'Please describe symptoms you may feel related to Kidney!',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                _buildDropdownRow(context,
                  label1: 'Specific Gravity',
                  hint1: 'Expresses urine density or concentration. Enter a numerical value that reflects the degree of concentration, such as 1.005.',
                  hint2: 'SG',
                  options: [
                    '<1.005 (Low)',
                    '1.005-1.015 (Normal)',
                    '1.015> (High)'
                  ],
                  onChanged: (value){
                  setState(() {
                    sgValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Albumin',
                  hint1: 'Expresses the level of protein that can be found in the blood and urine. Enter the appropriate number according to the medical report.',
                  hint2: 'Alb',
                  options: [
                    '0 (negative)',
                    '1-2 (trace to moderate)',
                    '<3 (severe)'
                  ],
                  onChanged: (value){
                  setState(() {
                    albValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Hemoglobin',
                  hint1: 'Expresses the level of hemoglobin in the blood. Enter the value in the appropriate unit such as g/dL.',
                  hint2: 'Hemo',
                  options: [
                    '<12 (Low)',
                    '13-16 (normal)',
                    '>16 (high)',

                  ],
                  onChanged: (value){
                  setState(() {
                    hemoValue=value;
                  });
                  }
                ),

                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Packed cell volume.',
                  hint1: ' Packed cell volume. Also known as hematocrit, this measures the volume percentage of red blood cells in blood. It is used to assess anemia and hydration status.',
                  hint2: 'pcv',
                  options: ['<37 (low)', '37-47 (normal)', '>47 (high)'],
                  onChanged: (value){
                  setState(() {
                    pcvValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Red blood cell count.',
                  hint1: 'Red blood cell count. This is a duplicate variable (similar to rbc) and may represent the same measurement.',
                  hint2: 'rc',
                  options: ['<4.5 (low)', '4.5-6 (normal)', '>6 (high)'],
                  onChanged: (value)
                    {
                      setState(() {
                        rcValue=value;
                      });
                    }
                ),
                SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {_getStatus();
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
  // int? sgValue;
  // int? albValue;
  // int? hemoValue;
  // int? pcvValue;
  // int? rcValue;
  Future<void> _getStatus() async {
    if (sgValue == null || albValue == null || hemoValue == null || pcvValue == null||rcValue==null) {
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

    final Map<String, dynamic> requestBody = {
      'sg': sgValue,
      'al': albValue,
      'hemo': hemoValue,
      'pcv': pcvValue,
      'rc': rcValue,
    };

    try {
      final response = await http.post(
        Uri.parse('https://10.0.2.2:3000/flask/kidney_predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Heart status: ${response.body}');
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
        print("response: ${response.body}");
        print('Failed with status code ${response.statusCode}');
        print("response: ${response.body}");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to get heart status. Please try again.'),
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
