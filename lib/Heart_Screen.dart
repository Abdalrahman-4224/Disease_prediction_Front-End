import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Ok_Rsult_Screen.dart';
import 'package:flutter_application_1/Notok_Result_Screen.dart';
class Heart extends StatefulWidget {
  const Heart({Key? key}) : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  int? cpValue;
  int? trestbpsValue;
  int? cholValue;
  int? restecgValue;
  int? thalachValue;
  int? exangValue;
  int? oldpeakValue;
  int? slopeValue;
  int? caValue;
  int? thalValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heart Disease',
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
                  'Please describe symptoms you may feel in your heart!',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                _buildDropdownRow(context,
                  label1: 'Chest Pain',
                  hint1: 'Type of pain in the chest (angina-like).',
                  hint2: 'CP',
                  options: [
                    'Typical angina',
                    'Atypical angina ',
                    'Non-anginal pain',
                    'Asymptomatic'
                  ],
                  onChanged: (value){
                  setState(() {
                    cpValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Blood Pressure',
                  hint1: 'Blood pressure value (in mm Hg).',
                  hint2: 'Trestbps',
                  options: [
                    '90-120 (Normal)',
                    '121-130 (Elevated)',
                    '131-140 (High stage)',
                    '141-180 (High stage 2)'
                  ],
                  onChanged: (value){
                  setState(() {
                    trestbpsValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Cholesterol',
                  hint1: 'The level of cholesterol in the blood (in mg/dL).',
                  hint2: 'Chol',
                  options: [
                    '60-100 (Low)',
                    '101-130 (Moderate)',
                    '131-160 (High)',
                    '161-200 (Very high)'
                  ],
                  onChanged: (value){
                  setState(() {
                    cholValue=value;
                  });

                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Resting ECG',
                  hint1: 'Resting ECG results (such as the electrical pulse).',
                  hint2: 'Restecg',
                  options: ['normal', 'having ST-T wave abnormality', ' showing probable or definite '],
                  onChanged: (value){
                  setState(() {
                    restecgValue=value;
                  });

                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Max Heart Rate',
                  hint1: 'Maximum heart rate achieved (in bpm).',
                  hint2: 'Thalach',
                  options: ['71 - 95 (low)',
                      ' 96 - 116 (moderate)',
                      ' 117 - 132 (high)',
                      '133 - 192 (very high)'],
                  onChanged: (value){
                  setState(() {
                    thalachValue=value;
                  });

                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Exercise Angina',
                  hint1: 'Chest pain as a result of exercise.',
                  hint2: 'Exang',
                  options: ['no', 'yes'],
                  onChanged: (value){
                  setState(() {
                    exangValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'ST Depression ',
                  hint1: 'A decrease in ST planning due to exercise compared to rest.',
                  hint2: 'Oldpeak',
                  options: [
                    '0-1 (Low)',
                    '1.1-2.0 (Moderate)',
                    '2.1-3.0 (High)',
                    '>3.1 (Very high)'
                  ],
                  onChanged: (value){
                  setState(() {
                    oldpeakValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Slope',
                  hint1: 'The slope of the apex in the ST layout during physical exercise.',
                  hint2: 'Slop',
                  options: ['upsloping', 'flat', 'downsloping'],
                  onChanged: (value){
                  setState(() {
                    slopeValue=value;
                  });
                  }
                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Vessels',
                  hint1: 'The number of damaged coronary arteries (usually shaded by epithelial imaging).',
                  hint2: 'Ca',
                  options: ['0 major vessels', '1 major vessel', '2 major vessels','3 major vessels'],
                  onChanged: (value){
                  setState(() {
                    caValue=value;
                  });
                  }

                ),
                SizedBox(height: 10.0),
                _buildDropdownRow(context,
                  label1: 'Thalassemia',
                  hint1: 'The type of thalassemia present (such as beta thalassemia)',
                  hint2: 'Thal',
                  options: [' 3 = normal', '6 = fixed defect', '7 = reversable defect'],
                  onChanged: (value){
                  setState(() {
                    thalValue=value;
                  });
                  }
                ),
                // Add more dropdown rows here
                SizedBox(
                  height: 16.0,
                ),
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
    if (cpValue == null || trestbpsValue == null || cholValue == null || restecgValue == null||thalachValue== null||exangValue==null||oldpeakValue==null||slopeValue==null||caValue==null||thalValue==null) {
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
      'cp': cpValue,
      'trestbps': trestbpsValue,
      'chol': cholValue,
      'restecg': restecgValue,
      'thalach': thalachValue,
      'exang': exangValue,
      'oldpeak': oldpeakValue,
      'slope': slopeValue,
      'ca': caValue,
      'thal': thalValue,
    };

    try {
      final response = await http.post(
        Uri.parse('https://10.0.2.2:3000/flask/heart_predict'),
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
