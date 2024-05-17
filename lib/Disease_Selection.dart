import 'package:flutter/material.dart';
import 'Heart_Screen.dart';
import 'liver_Screen.dart';
import 'Kidney_Screen.dart';
import 'Diabetes_Screen.dart';
import 'variables.dart';
class DiseaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disease Selection',
      home: DiseaseSelectionScreen(),
    );
  }
}

class DiseaseSelectionScreen extends StatefulWidget {
  @override
  _DiseaseSelectionScreenState createState() => _DiseaseSelectionScreenState();
}

class _DiseaseSelectionScreenState extends State<DiseaseSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff032E61),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                'Select one of the disease you want to diagnose',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 45,
                ),
              ),
            ),
            DiseaseOption(
              ontap: () {
                Mcode=1;
                print('Mcode= ${Mcode}');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Heart(),
                    ));
              },
              imgurl: 'assets/heart.png',
              label: 'Heart disease',
              color: Colors.white,
            ),
            DiseaseOption(
              ontap: () {
                Mcode=2;
                print('Mcode= ${Mcode}');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Kidney(),
                    ));
              },
              imgurl: 'assets/kidney.png',
              label: 'Kidney disease',
              color: Colors.white,
            ),
            DiseaseOption(
              ontap: () {
                Mcode=3;
                print('Mcode= ${Mcode}');

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiverScreen(),
                    ));
              },
              imgurl: 'assets/liver.png',
              label: 'Liver disease',
              color: Colors.white,
            ),
            DiseaseOption(
              ontap: () {
                Mcode=4;
                print('Mcode= ${Mcode}');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Diabetes(),
                    ));
              },
              imgurl: 'assets/Diabetes.png',
              label: 'Diabetes',
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class DiseaseOption extends StatelessWidget {
  final String label;
  final Color color;
  final String imgurl;
  final Function ontap;

  const DiseaseOption({
    required this.label,
    required this.color,
    required this.imgurl,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.18,
                child: Image.asset(imgurl)),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                  color: Color(0xff032E61),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
