import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:graduation_projects/adminpases/addclass.dart';
import 'package:graduation_projects/adminpases/adding_project.dart';
import 'package:graduation_projects/adminpases/allclass.dart';
import 'package:graduation_projects/adminpases/assignprojects.dart';

import 'package:graduation_projects/adminpases/supervisor.dart';
import 'package:graduation_projects/adminpases/veiwstudent.dart';
import 'package:graduation_projects/adminpases/veiwsupervisor.dart';

import 'package:graduation_projects/screens/loginscreen.dart';
import 'package:graduation_projects/screens/searching.dart';

class adminpage extends StatefulWidget {
  const adminpage({super.key});

  @override
  State<adminpage> createState() => _adminpageState();
}

class _adminpageState extends State<adminpage> {
  final _firestore = FirebaseFirestore.instance;

  var std11 = TextEditingController();
  var std22 = TextEditingController();
  var title = TextEditingController();
  var desc = TextEditingController();
  var focult = TextEditingController();
  var phone = TextEditingController();
  var programs = TextEditingController();
  var supervisors = TextEditingController();
  var startdates = TextEditingController();
  var ensdates = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Asearach();
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.search),
                ),
                SizedBox(
                  width: 50,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return loginpage();
                        },
                      ));
                    },
                    child: Icon(Icons.logout)),
              ],
              centerTitle: true,
              backgroundColor: Colors.purple[800],
              title: Text(
                "admin page",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            drawer: SizedBox(
              width: 200,
              child: Drawer(
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(
                        height: 100,
                        child: const DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                          ),
                          child: Text(
                            'MENU',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'add new class',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return addclass();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'all class',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return allclass();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'add supervisor',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return supervisorpage();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'all student',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return veiwstudent();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'all supervisors',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return veiwsupervisor();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'assign project',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return assignproject();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'all students',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return veiwstudent();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('assignproject').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Wax Baa qaldan");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Fadlan sug inyar');
                  }
                  final info = snapshot.data!.docs;
                  final titleNames = [];
                  var titleDesc = [];
                  var IDs = [];
                  var superVsor = [];
                  var std1 = [];
                  var std2 = [];
                  var pholist = [];

                  for (var information in info) {
                    var titleName = information.get('titleName');
                    var titleDesription = information.get('titledesc');
                    var supervis = information.get('supervisor');
                    var st1 = information.get('student1');
                    var st2 = information.get('student2');
                    var phn = information.get('groupNum');

                    IDs.add(information.id);

                    titleNames.add(titleName);
                    titleDesc.add(titleDesription);
                    superVsor.add(supervis);
                    std1.add(st1);
                    pholist.add(phn);
                    std2.add(st2);
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: titleNames.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: ListTile(
                            title: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Expanded(
                                        child: AlertDialog(
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Table(
                                                border: TableBorder.all(),
                                                children: [
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'student1',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${std1[index]}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'student2',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${std2[index]}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'supervisor',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${superVsor[index]}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'title name',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${titleNames[index]}',
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        'title description',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${titleDesc[index]}',
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text('${titleNames[index]}')),
                            subtitle: Text('${titleDesc[index]}'),
                            trailing: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      std11.text = std1[index];
                                      std22.text = std2[index];
                                      title.text = titleNames[index];
                                      desc.text = titleDesc[index];
                                      phone.text = pholist[index];

                                      supervisors.text = superVsor[index];
                                    });
                                    // usig show diolog ba
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: std11,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            'first student')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller: std22,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            'second student')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller: supervisors,
                                                    decoration: InputDecoration(
                                                        label:
                                                            Text('supervisor')),
                                                  ),
                                                  TextFormField(
                                                    controller: title,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            'title project')),
                                                  ),
                                                  TextFormField(
                                                    controller: desc,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            'title description')),
                                                  ),
                                                  TextFormField(
                                                    controller: phone,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            'phone number')),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _firestore
                                                        .collection(
                                                            'assignproject')
                                                        .doc(IDs[index])
                                                        .update({
                                                      'student1': std11.text,
                                                      'student2': std22.text,
                                                      'titleName': title.text,
                                                      'titledesc': desc.text,
                                                      'groupNum': phone.text,
                                                    }).then((value) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return adminpage();
                                                          },
                                                        ),
                                                      );
                                                    });
                                                  },
                                                  child: Text('update'))
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Delete
                                    _firestore
                                        .collection('assignproject')
                                        .doc(IDs[index])
                                        .delete();
                                    // print('dont delete me');
                                  },
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }));
                },
              ),
              // child:
            )));
  }
}
