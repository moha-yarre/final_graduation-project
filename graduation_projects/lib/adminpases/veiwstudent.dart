import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';

class veiwstudent extends StatefulWidget {
  const veiwstudent({super.key});

  @override
  State<veiwstudent> createState() => _veiwstudentState();
}

class _veiwstudentState extends State<veiwstudent> {
  final _firestores = FirebaseFirestore.instance;

  var STDName = TextEditingController();
  var address = TextEditingController();
  var phones = TextEditingController();

  var emails = TextEditingController();
  var classnames = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.purple[800],
              title: Text("all student"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return adminpage();
                      },
                    ),
                  );
                },
              ),
            ),
            body: SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestores.collection('student').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Wax Baa qaldan");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Fadlan sug inyar');
                  }
                  final info = snapshot.data!.docs;

                  var IDs = [];
                  var stdanameslist = [];
                  var adresslist = [];
                  var phonelist = [];
                  var emaillist = [];
                  var claslist = [];

                  for (var information in info) {
                    var stdnamevar = information.get('stdname');
                    var phonevar = information.get('phone');
                    var addressvar = information.get('address');
                    var emailvar = information.get('email');
                    var classvar = information.get('className');

                    IDs.add(information.id);

                    stdanameslist.add(stdnamevar);
                    phonelist.add(phonevar);
                    adresslist.add(addressvar);
                    emaillist.add(emailvar);
                    claslist.add(classvar);
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: stdanameslist.length,
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AlertDialog(
                                              title: Text("student info"),

                                              // content: Text('GeeksforGeeks'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(titleNames[index]),
                                                  Table(
                                                    border: TableBorder.all(),
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.start,
                                                    children: [
                                                      TableRow(
                                                        children: [
                                                          Text(
                                                            'student name',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${stdanameslist[index]}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          Text('class'),
                                                          Text(
                                                              '${claslist[index]}'),
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          Text('address'),
                                                          Text(
                                                              '${adresslist[index]}'),
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          Text('phone'),
                                                          Text(
                                                              '${phonelist[index]}'),
                                                        ],
                                                      ),
                                                      TableRow(
                                                        children: [
                                                          Text('email'),
                                                          Text(
                                                              '${emaillist[index]}'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text('${stdanameslist[index]}')),
                            subtitle: Text('${claslist[index]}'),
                            trailing: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      STDName.text = stdanameslist[index];
                                      classnames.text = claslist[index];
                                      address.text = adresslist[index];

                                      phones.text = phonelist[index];
                                      emails.text = emaillist[index];
                                    });
                                    // usig show diolog ba
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: AlertDialog(
                                            // title: Text('Welcome'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                // shrinkWrap: true,
                                                children: [
                                                  TextFormField(
                                                    controller: STDName,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            ' student name')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller: classnames,
                                                    decoration: InputDecoration(
                                                        label:
                                                            Text('class name')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller: address,
                                                    decoration: InputDecoration(
                                                        label: Text('address')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller: emails,
                                                    decoration: InputDecoration(
                                                        label: Text('email')),
                                                  ),
                                                  TextFormField(
                                                    controller: phones,
                                                    decoration: InputDecoration(
                                                        label: Text('phone')),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _firestores
                                                        .collection('student')
                                                        .doc(IDs[index])
                                                        .update({
                                                      'stdname': STDName.text,
                                                      // 'studentname2': std2.text,
                                                      'className':
                                                          classnames.text,
                                                      'address': address.text,

                                                      'phone': phones.text,
                                                      'email': emails.text
                                                    }).then((value) {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return adminpage();
                                                        },
                                                      ));
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
                                    _firestores
                                        .collection('student')
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
