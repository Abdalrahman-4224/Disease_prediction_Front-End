import 'package:flutter/material.dart';
import 'signup.dart';
import 'Evacuation_responsibilaty.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            PopupMenuButton(
              icon: Icon(
                Icons.menu_rounded,
                size: 40,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      child: Column(children: [
                        ListTile(
                          leading: Icon(Icons.contact_mail),
                          title: Text('Contact Us'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Who Us'),
                          onTap: () {},
                        )
                      ])),
                ];
              },
            ),
          ],
        ),
        // title: Text('Start',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor:Color.fromARGB(255, 2, 38, 99),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/GraphicDoctorStart.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DisclaimerAndNotes()),
                  ); // Add your onPressed action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue
                      .withOpacity(0.2), // ....تحديد لون الزر وتعديل شفافيته
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                        color:
                            Color.fromARGB(157, 72, 101, 124).withOpacity(0.9)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
