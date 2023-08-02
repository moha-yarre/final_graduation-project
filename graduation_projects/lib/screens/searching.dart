import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:kediye/Registrations&Login/middle.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';

class Input {
  Input({required this.titleName, required this.titleDescription});
  // final String SHopName;
  final String titleName;
  final String titleDescription;
}

class Asearach extends StatefulWidget {
  @override
  State<Asearach> createState() => _AsearachState();
}

class _AsearachState extends State<Asearach> {
  final _firestore = FirebaseFirestore.instance;
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('assignproject');
  var searach;
  var isActive = false;
  var isChecked = false;
  var ID;
  getUsers(name) async {
    var id;
    await for (var element
        in _firestore.collection('assignproject').snapshots()) {
      for (var i in element.docs) {
        var n = i.get('titleName');
        var q = i.get('titledesc');

        if (n == name) {
          // print(i.id);
          setState(() {
            id = i.id;
          });
        }
      }
      // print(id);
      ID = id;
      return id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, routeName)
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 27,
                color: Color(0xff5717E2),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    searach = value;
                  });
                },
                decoration: InputDecoration(),
              ),
              // decoration: InputDeco("Search Here"),
              // decoration: InputDeco("search")
              //     .copyWith(prefixIcon: Icon(Icons.search))),
            ),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: ListView(shrinkWrap: true, children: [
            StreamBuilder<QuerySnapshot>(
                stream: _collectionReference.snapshots(),
                // stream: _firestore.collection('custRegister').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['titleName']
                              .toString()
                              .toLowerCase()
                              .startsWith(searach.toString().toLowerCase()))
                      .isEmpty) {
                    return Center(
                      child: Text("There is no data"),
                    );
                  } else {
                    return ListView(shrinkWrap: true, children: [
                      ...snapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element) =>
                              element['titleName']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searach.toString().toLowerCase()))
                          .map((QueryDocumentSnapshot<Object?> data) {
                        List<Input> infos = [];
                        final titleName = data.get('titleName');
                        final titleDesc = data.get('titledesc');

                        infos.add(Input(
                            titleName: titleName, titleDescription: titleDesc));
                        // }
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              // showBottomBorder: true,
                              headingRowHeight: 0,
                              // dataRowHeight: double.parse('20'),

                              columnSpacing: 20,
                              columns: [
                                DataColumn(label: Text('')),
                              ],
                              rows: infos
                                  .map((e) => DataRow(cells: [
                                        DataCell(Text(e.titleName)),
                                      ]))
                                  .toList()),
                        );
                      }

                              // Input(CustName: name, TellNumber: phone));

                              )
                    ]);
                  }
                })
          ]))
    ])));
  }
}
