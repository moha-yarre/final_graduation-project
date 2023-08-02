import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:graduation_projects/adminpases/add_student.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';
import 'package:graduation_projects/adminpases/allclass.dart';
import 'package:graduation_projects/adminpases/registrationstudent.dart';

class homeclass extends StatefulWidget {
  // const homeclass({super.key});
  // final className;
  final String tappedName;
  homeclass({required this.tappedName});

  // homeclass{(required this.cla)}

  @override
  State<homeclass> createState() => _homeclassState();
}

class _homeclassState extends State<homeclass> {
  final _firestores = FirebaseFirestore.instance;
  final phoneeditingcontroller = new TextEditingController();
  final addresseditingcontroller = new TextEditingController();
  final emaileditingcontroller = new TextEditingController();
  final studentnameeditingcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "${widget.tappedName} ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => allclass(),
                            ),
                          );
                        },
                        icon: Icon(Icons.keyboard_backspace_outlined),
                      ),
                    ],
                  ),
                )
              ],
              backgroundColor: Colors.purple[800],
              elevation: 0,
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
                          'add new student',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return registrationsstudents(
                                  tappedName: widget.tappedName,
                                );
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
                  final stdnamelist = [];
                  var phonelist = [];
                  var IDs = [];
                  var emalist = [];
                  var addresslist = [];

                  for (var information in info) {
                    var stdname = information.get('stdname');
                    var phones = information.get('phone');
                    var addres = information.get('address');
                    var emsl = information.get('email');
                    var className = information.get('className');
                    if (widget.tappedName == className &&
                        stdnamelist.contains(stdname) == false) {
                      IDs.add(information.id);

                      stdnamelist.add(stdname);
                      phonelist.add(phones);
                      emalist.add(emsl);
                      addresslist.add(addres);
                    }
                    // var st2 = information.get('student2');

                    // std2.add(st2);
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: stdnamelist.length,
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
                                          title: Text(stdnamelist[index]),
                                          // content: Text('GeeksforGeeks'),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Text(titleNames[index]),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text('${stdnamelist[index]}')),
                            // subtitle: Text('${titleDesc[index]}'),
                            trailing: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      studentnameeditingcontroller.text =
                                          stdnamelist[index];
                                      phoneeditingcontroller.text =
                                          phonelist[index];
                                      addresseditingcontroller.text =
                                          addresslist[index];
                                      emaileditingcontroller.text =
                                          emalist[index];
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
                                                    controller:
                                                        studentnameeditingcontroller,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            ' student name')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller:
                                                        phoneeditingcontroller,
                                                    decoration: InputDecoration(
                                                        label: Text('phone')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller:
                                                        addresseditingcontroller,
                                                    decoration: InputDecoration(
                                                        label: Text('address')),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextFormField(
                                                    controller:
                                                        emaileditingcontroller,
                                                    decoration: InputDecoration(
                                                        label: Text('email')),
                                                  ),
                                                  SizedBox(height: 5),
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
                                                      'stdname':
                                                          studentnameeditingcontroller
                                                              .text,
                                                      'phone':
                                                          phoneeditingcontroller
                                                              .text,
                                                      'address':
                                                          addresseditingcontroller
                                                              .text,
                                                      'email':
                                                          emaileditingcontroller
                                                              .text,
                                                    }).then((value) {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return homeclass(
                                                            tappedName: widget
                                                                .tappedName,
                                                          );
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
