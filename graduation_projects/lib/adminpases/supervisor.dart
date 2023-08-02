// import 'package:final_project/admin%20page/adding_project.dart';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_projects/adminpases/adding_project.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';
import 'package:graduation_projects/adminpases/veiwsupervisor.dart';

class supervisorpage extends StatefulWidget {
  const supervisorpage({super.key});

  @override
  State<supervisorpage> createState() => _supervisorpageState();
}

class _supervisorpageState extends State<supervisorpage> {
  @override
  final _formkey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  // editing
  final supervisornameeditingcontroller = new TextEditingController();
  final addresseditincontroller = new TextEditingController();
  final emaleditingcontroller = new TextEditingController();
  final phoneeditingcontroller = new TextEditingController();
  final passwordeditingcontroller = new TextEditingController();
  final confirmpasswordeditingcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final supervisornamefield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter supervisor name';
        }
      },
      autofocus: false,
      controller: supervisornameeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        supervisornameeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "supervisor name"),
    );
// second name field Halkan waa ka sameeyey fucntion second name ka
    final addresfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter address';
        }
      },
      autofocus: false,
      controller: addresseditincontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        addresseditincontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_to_drive_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "address"),
    );
    // phone field
    final phonefield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter phoen number';
        }
      },
      autofocus: false,
      controller: phoneeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        phoneeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter your phone"),
    );

//email field Halkan waa ka sameeyey fucntion email ka
    final emailfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter Email';
        }
      },
      autofocus: false,
      controller: emaleditingcontroller,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emaleditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter email"),
    );
// password field Halkan waa ka sameeyey fucntion password ka
    final passwordfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter  password';
        }
      },
      autofocus: false,
      obscureText: true,
      controller: passwordeditingcontroller,
      onSaved: (value) {
        passwordeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "enter password"),
    );
    // confirm password field Halkan waa ka sameeyey fucntion sconfirm password ka
    final confirmfield = TextFormField(
      validator: (value) {
        // return 'Fadlan password saxan gali';
        if (passwordeditingcontroller.text !=
            confirmpasswordeditingcontroller.text) {
          return 'please enter same password';
        }
      },
      autofocus: false,
      obscureText: true,
      controller: confirmpasswordeditingcontroller,
      onSaved: (value) {
        confirmpasswordeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "confirm password"),
    );
    // signup button field Halkan waa ka sameeyey fucntion signup ka
    final signUPButton = Material(
      color: Colors.purple[800],
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              // print('dont touch me');
              // _firestore.app\
              // _firestore
              final fireAuth = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emaleditingcontroller.text,
                      password: passwordeditingcontroller.text);
              // if(fireAuth)
              // print(fireAuth.user);
              if (fireAuth.user != null) {
                _firestore.collection('users').add({
                  'fname': supervisornameeditingcontroller.text,
                  'lname': supervisornameeditingcontroller.text,
                  'address': addresseditincontroller.text,
                  'email': emaleditingcontroller.text,
                  'pass': passwordeditingcontroller.text,
                  'phone': phoneeditingcontroller.text,
                  'isAdmin': false,
                  'isSuperVisor': true,
                  // 'isAdmin': false
                }).then((value) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return adminpage();
                    },
                  ));
                });
                //
              }
            }
          },
          child: Text(
            "Register",
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
            centerTitle: true,
            title: Text(
              "add new supervisor",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.purple[800],
            elevation: 0,
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
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
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
                          supervisornamefield,
                          SizedBox(
                            height: 5,
                          ),
                          addresfield,
                          SizedBox(
                            height: 5,
                          ),
                          phonefield,
                          SizedBox(
                            height: 5,
                          ),
                          emailfield,
                          SizedBox(
                            height: 5,
                          ),
                          passwordfield,
                          SizedBox(
                            height: 5,
                          ),
                          confirmfield,
                          SizedBox(
                            height: 5,
                          ),
                          signUPButton,
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
