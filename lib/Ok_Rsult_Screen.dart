import 'package:flutter/material.dart';

class OkScreen extends StatelessWidget {
  const OkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
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
                height: MediaQuery.of(context).size.height * 0.09,
                child: Center(
                  child: Text(
                    'Based on the symptoms you provided and the analysis, it seems that you do not exhibit signs of the disease. However, it\'s always advisable to continue monitoring your health and consult a healthcare professional for further guidance',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      fontSize: MediaQuery.of(context).size.height * 0.028,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Image.asset('assets/happy doctor design (green).png')
        ],
      ),
    );
  }
}


// RichText(
// text: TextSpan(
// text: 'Your symptoms indicate a potentially serious condition that ',
// style:
// children:  <TextSpan>[
// TextSpan(text: 'demands urgent medical attention! ', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: MediaQuery.of(context).size.height*0.034)),
// TextSpan(text: ' . Please prioritize seeking professional assistance to address these concerns promptly. see suggested doctors below:'),
// ],
// ),
// ),