import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/variables.dart';
import 'package:http/http.dart' as http;
import 'DoctorsScreen.dart';
class NotOkScreen extends StatefulWidget {
  const NotOkScreen({Key? key}) : super(key: key);

  @override
  State<NotOkScreen> createState() => _NotOkScreenState();
}

class _NotOkScreenState extends State<NotOkScreen> {
  List<Governorate>? governorateNames;
  String? selectedGovernorate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Color.fromARGB(255, 2, 38, 99),
        title: Text(
          'Result:',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: 'Your symptoms indicate a potentially serious condition that ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontSize: MediaQuery.of(context).size.height * 0.028,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'demands urgent medical attention!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: MediaQuery.of(context).size.height * 0.034,
                          ),
                        ),
                        TextSpan(
                          text: ' Please prioritize seeking professional assistance to address these concerns promptly.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FutureBuilder<List<Governorate>>(
                        future: fetchGovernoratesList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to load data from the server'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          } else {
                            governorateNames = snapshot.data;
                            return AlertDialog(
                              title: Text('Suggested Doctors'),
                              content: DropdownButton<String>(
                                hint: Text(selectedGovernorate ?? 'Governorates'),
                                items: governorateNames!.map((governorate) {
                                  return DropdownMenuItem<String>(
                                    value: governorate.name,
                                    child: Text(governorate.name),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  Gcode = governorateNames![snapshot.data!.indexWhere((g) => g.name == newValue)]!.code;
                                  print("code: ${Gcode}");
                                  setState(() {
                                    selectedGovernorate = newValue; // Update the selected governorate name
                                  });
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (selectedGovernorate == null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text('Please select a governorate.'),
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
                                    } else {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorListScreen()));
                                    }
                                  },
                                  child: Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the AlertDialog
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    },
                  );
                },
                child: Text(
                  'Suggest Doctors',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 2, 38, 99),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 30.0,
                  ),
                ),
              ),
            ),
          ),
          Image.asset('assets/confused doctor (red).png')
        ],
      ),
    );
  }
  Future<List<Governorate>> fetchGovernoratesList() async {
    final response = await http.get(Uri.parse('https://10.0.2.2:3000/governorates/'), headers: {'jwt': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxLCJuYW1lIjoidGVzdCBuYW1lIiwidXNlcm5hbWUiOiJ0ZXN0Iiwicm9sZV9pZHMiOls1Nl19LCJpYXQiOjE3MTQxMzcyMzJ9.l7rbdY71bjNlw9Pwxy9tZ0ZqrSF4a04uVML1HMRXYMA'});

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Governorate> governorateNames = data.map((governorate) => Governorate(
        name: governorate['name'] as String,
        code: governorate['code'] as String,
      )).toList();
      return governorateNames;
    } else {
      throw Exception('Failed to load data from the server');
    }
  }
}




