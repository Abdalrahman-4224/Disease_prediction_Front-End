import 'package:flutter/material.dart';
import 'Disease_Selection.dart';

class DisclaimerAndNotes extends StatefulWidget {
  @override
  _DisclaimerAndNotesState createState() => _DisclaimerAndNotesState();
}

class _DisclaimerAndNotesState extends State<DisclaimerAndNotes> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 38, 99),
        title: Text('Medical Disclaimer & Consent'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BulletText(
              text:
              'This application bases on advanced artificial intelligence techniques to provide accurate medical diagnosis for heart, diabetes, liver, and kidney diseases.',
            ),
            BulletText(
              text:
              'The diagnosis depends on the symptoms and laboratory tests provided by the patient.',
            ),
            BulletText(
              text:
              'The accuracy of the diagnosis depends entirely on the accuracy of the patient data.',
            ),
            BulletText(
              text:
              'Doctors and specialists must be consulted to prescribe the appropriate treatment, rather than relying solely on the diagnosis provided by the application for therapeutic medication',
            ),
            SizedBox(height: 16.0),

            SizedBox(height: 8.0),
            Text(
              'This application does not provide evacuation recommendations in case of emergencies. Please contact emergency services or medical professionals for such decisions.',
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
              textAlign:TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Text(
                  'I agree to disclaimer and notes',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _isChecked
                    ? () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DiseaseSelectionScreen()));
                }
                    : null,
                child: Text(
                  'Next',
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
    );
  }
}

class BulletText extends StatelessWidget {
  final String text;

  const BulletText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
