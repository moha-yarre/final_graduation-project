import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:graduation_projects/adminpases/add_student.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';
import 'package:graduation_projects/adminpases/homeclass.dart';

class allclass extends StatefulWidget {
  const allclass({super.key});

  @override
  State<allclass> createState() => _allclassState();
}

class _allclassState extends State<allclass> {
  final _firestores = FirebaseFirestore.instance;
  var classs = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple[800],
          title: Text("all class"),
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
            stream: _firestores.collection('class').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Wax Baa qaldan");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Fadlan sug inyar');
              }
              final info = snapshot.data!.docs;
              final CLASLIST = [];

              var IDs = [];

              for (var information in info) {
                var CLAS = information.get('classname');
                if (CLASLIST.contains(CLAS) == false) {
                  IDs.add(information.id);
                  CLASLIST.add(CLAS);
                }
              }
              return GestureDetector(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: CLASLIST.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: ListTile(
                          title: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return homeclass(
                                        tappedName: CLASLIST[index],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text('${CLASLIST[index]}')),
                          // subtitle: Text('${titleDesc[index]}'),
                          trailing: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    classs.text = CLASLIST[index];
                                  });
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
                                      .collection('class')
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
                    })),
              );
            },
          ),
          // child:
        ),
      ),
    );
  }
}
