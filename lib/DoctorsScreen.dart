import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/variables.dart';
import 'package:http/http.dart' as http;

class DoctorListScreen extends StatefulWidget {
  // Pass the code from the previous screen

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  Future<List<DoctorsList>>? _doctorsFuture;

  @override
  void initState() {
    super.initState();
    _doctorsFuture = fetchDoctors(Gcode, Mcode); // Call the function from variables.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 38, 99),
        title: Text("Doctors List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _doctorsFuture = fetchDoctors(Gcode, Mcode);
          });
        },
        child: FutureBuilder<List<DoctorsList>>(
          future: _doctorsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final doctors = snapshot.data!;
              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(doctor: doctor); // Use a custom DoctorCard widget
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            // Display a loading indicator while fetching data
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<List<DoctorsList>> fetchDoctors(var code1, var code2) async {
    String Doctorsuri = 'https://10.0.2.2:3000/doctors?code=$code1-$code2';
    final response = await http.get(
      Uri.parse(Doctorsuri),
      headers: {'jwt': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxLCJuYW1lIjoidGVzdCBuYW1lIiwidXNlcm5hbWUiOiJ0ZXN0Iiwicm9sZV9pZHMiOls1Nl19LCJpYXQiOjE3MTQxMzcyMzJ9.l7rbdY71bjNlw9Pwxy9tZ0ZqrSF4a04uVML1HMRXYMA'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      final doctors = data.map((doctor) => DoctorsList.fromJson(doctor)).toList();
      return doctors;
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}
class DoctorCard extends StatelessWidget {
  final DoctorsList doctor;

  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100, // Adjust the width as needed
                height: 100, // Adjust the height as needed
                child: Image.asset(
                  'assets/user.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16), // Add some spacing between the image and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' الدكتور: ${doctor.name}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8), // Add some vertical spacing between title and subtitle
                    Text(
                      'العنوان: ${doctor.address}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'رقم الهاتف: ${doctor.phoneNumber}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


