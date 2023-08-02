// import 'package:final_project/screens/loginscreen.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_projects/screens/loginscreen.dart';
// import 'package:final_project/screens/searching.dart';
// import 'package:final_project/admin page/adminpage.dart';
import 'package:graduation_projects/screens/searching.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'logginscre.dart';
// import 'logi'

class SuperVisorView extends StatefulWidget {
  var currentLoggedIn;
  SuperVisorView({required this.currentLoggedIn});
  // const home({super.key});

  @override
  State<SuperVisorView> createState() => _SuperVisorView();
}

class _SuperVisorView extends State<SuperVisorView> {
  @override
  Widget build(BuildContext context) {
    sendWhatsapMsg({
      required phone,
    }) async {
      String url() {
        if (Platform.isIOS) {
          return 'whatsapp://wa.me/$phone}';
        } else {
          return 'whatsapp://send?phone=$phone';
        }
      }

      await canLaunchUrl(Uri.parse(url()))
          ? launchUrl(Uri.parse(url()))
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Macmiilkaan whatsapp Malahan")));
    }

    _launchWhatsapp() async {
      var whatsapp = "619341581";
      var whatsappAndroid = Uri.parse("https://wa.me/$whatsapp");
      if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("WhatsApp is not installed on the device"),
          ),
        );
      }
    }

    final _firestore = FirebaseFirestore.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: Colors.purple[800],
          // leading:
          title: Text(
            "${widget.currentLoggedIn}",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),

          actions: [
            Padding(
              padding: EdgeInsets.only(right: 30),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return loginpage();
                          },
                        ));
                      },
                      child: Icon(Icons.logout))
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('assignproject').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Wax Baa qaldan");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Fadlan sug inyar');
              }
              final info = snapshot.data!.docs;
              var students2 = [];
              var titleNames = [];
              var students1 = [];
              var titledesc = [];

              var supervisors = [];
              // var programs = [];
              // var stduents1 = [];
              var Listy = [];
              var IDs = [];
              for (var information in info) {
                // if (supervisors == true) {
                var superVisorName = information.get('supervisor');
                var stud1 = information.get('student1');
                var stud2 = information.get('student2');

                var desc = information.get('titledesc');
                var titleName = information.get('titleName');
                var naka = information.get('groupNum');
                if (widget.currentLoggedIn.toString().toLowerCase() ==
                    superVisorName.toString().toLowerCase()) {
                  if (superVisorName.toString().isNotEmpty) {
                    IDs.add(information.id);

                    titleNames.add(titleName);
                    students1.add(stud1);
                    students2.add(stud2);
                    Listy.add(naka);

                    titledesc.add(desc);
                    supervisors.add(superVisorName);
                  }
                }
              }
              // }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: titleNames.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('$index'),
                        ),
                        title: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Expanded(
                                    child: AlertDialog(
                                      title: Text(titleNames[index]),
                                      content: Column(
                                        children: [
                                          Table(
                                            border: TableBorder.all(),
                                            children: [
                                              TableRow(
                                                children: [
                                                  Text(
                                                    'student one',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${students1[index]}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Text('student two'),
                                                  Text('${students2[index]}'),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Text('title'),
                                                  Text('${titleNames[index]}'),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Text('desccription'),
                                                  Text('${titleNames[index]}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text('${titleNames[index]}')),
                        trailing: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: GestureDetector(
                                onTap: () {
                                  sendWhatsapMsg(phone: Listy[index]);
                                },
                                child: Icon(
                                  Icons.line_axis_outlined,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     // Delete
                            //     _firestore
                            //         .collection('assignproject')
                            //         .doc(IDs[index])
                            //         .update({});
                            //   },
                            //   child: Icon(
                            //     Icons.remove_circle_outline,
                            //     color: Colors.red,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  }));
            },
          ),
        ),
      ),
    );
  }
}
