// import 'package:final_project/admin%20page/adminpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';

class addingpage extends StatefulWidget {
  const addingpage({super.key});

  @override
  State<addingpage> createState() => _addingpageState();
}

class _addingpageState extends State<addingpage> {
  final _formkey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  // editing
  final firtsstudentditingcontroller = new TextEditingController();
  final secondstudenteditincontroller = new TextEditingController();
  final facultyditingcontroller = new TextEditingController();
  final programeditingcontroller = new TextEditingController();
  final Batcheditingcontroller = new TextEditingController();
  final supervissoreditingcontroller = new TextEditingController();
  final Titleeditingcontroller = new TextEditingController();
  final descriptioneditingcontroller = new TextEditingController();
  final stardateeditingcontroller = new TextEditingController();
  final enddateeditingcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final firststudent = TextFormField(
      autofocus: false,
      controller: firtsstudentditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        firtsstudentditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter first student"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final secondstudent = TextFormField(
      autofocus: false,
      controller: secondstudenteditincontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        secondstudenteditincontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter second student "),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final faculty = TextFormField(
      autofocus: false,
      controller: facultyditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        facultyditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter faculty"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final program = TextFormField(
      autofocus: false,
      controller: programeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        programeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter program"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final batch = TextFormField(
      autofocus: false,
      controller: Batcheditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        Batcheditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter batch"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final supervissor = TextFormField(
      autofocus: false,
      controller: supervissoreditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        supervissoreditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter supervissor"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final Title = TextFormField(
      autofocus: false,
      controller: Titleeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        Titleeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter title project"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final description = TextFormField(
      autofocus: false,
      controller: descriptioneditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        descriptioneditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter description of this project"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final startdate = TextFormField(
      autofocus: false,
      controller: stardateeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        stardateeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter start date"),
    );
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final enddate = TextFormField(
      autofocus: false,
      controller: enddateeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        enddateeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter end"),
    );
    final addproject = Material(
      color: Colors.purple[800],
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            _firestore.collection('projects').add({
              'student1': firtsstudentditingcontroller.text,
              'student2': secondstudenteditincontroller.text,
              'foculty': facultyditingcontroller.text,
              'batch': Batcheditingcontroller.text,
              'program': programeditingcontroller.text,
              'supervisor': supervissoreditingcontroller.text,
              'titleName': Titleeditingcontroller.text,
              'titleDesc': descriptioneditingcontroller.text,
              'endDate': enddateeditingcontroller.text,
              'startDate': stardateeditingcontroller.text
            }).then((value) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return adminpage();
                },
              ));
            });
          },
          child: Text(
            "Add project",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return adminpage();
                  },
                ));
              },
            ),
            backgroundColor: Colors.purple[800],
            centerTitle: true,
            title: Text(
              "add new project",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          firststudent,
                          SizedBox(
                            height: 5,
                          ),
                          secondstudent,
                          SizedBox(
                            height: 5,
                          ),
                          faculty,
                          SizedBox(
                            height: 5,
                          ),
                          program,
                          SizedBox(
                            height: 5,
                          ),
                          batch,
                          SizedBox(
                            height: 5,
                          ),
                          supervissor,
                          SizedBox(
                            height: 5,
                          ),
                          Title,
                          SizedBox(
                            height: 5,
                          ),
                          description,
                          SizedBox(
                            height: 5,
                          ),
                          startdate,
                          SizedBox(
                            height: 5,
                          ),
                          enddate,
                          SizedBox(
                            height: 5,
                          ),
                          addproject,
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
