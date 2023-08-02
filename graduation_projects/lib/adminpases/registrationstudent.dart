import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_projects/adminpases/homeclass.dart';
import 'package:graduation_projects/screens/homepage.dart';

class registrationsstudents extends StatefulWidget {
  // const registrationsstudents({super.key});
  final tappedName;
  registrationsstudents({required this.tappedName});

  @override
  State<registrationsstudents> createState() => _registrationsstudentsState();
}

class _registrationsstudentsState extends State<registrationsstudents> {
  final _formkey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final studentnameeditingcontroller = new TextEditingController();
  // final focultyditincontroller = new TextEditingController();
  // final programditingcontroller = new TextEditingController();
  // final batcheditingcontroller = new TextEditingController();
  final phoneeditingcontroller = new TextEditingController();
  final addresseditingcontroller = new TextEditingController();
  final emaileditingcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter student name';
        }
      },
      autofocus: false,
      controller: studentnameeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        studentnameeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "student name"),
    );
    final addressfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter address';
        }
      },
      autofocus: false,
      controller: addresseditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        addresseditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "address"),
    );
    final phonefield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter phone number';
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
          hintText: "phone"),
    );
    final emailfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Email';
        }
      },
      autofocus: false,
      controller: emaileditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        emaileditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "email"),
    );
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

              // if(fireAuth)
              // print(fireAuth.user);

              _firestore.collection('student').add({
                'stdname': studentnameeditingcontroller.text,
                'email': emaileditingcontroller.text,
                'address': addresseditingcontroller.text,
                'phone': phoneeditingcontroller.text,
                'className': widget.tappedName
                // 'isAdmin': false
              }).then((value) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return homeclass(tappedName: widget.tappedName);
                  },
                ));
                // print('succed');
              });
            }
            //
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
              "student Registration ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.purple[800],
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return homeclass(tappedName: widget.tappedName);
                  },
                ));
              },
            ),
          ),
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
                          studentfield,
                          SizedBox(
                            height: 20,
                          ),
                          phonefield,
                          SizedBox(
                            height: 20,
                          ),
                          addressfield,
                          SizedBox(
                            height: 20,
                          ),
                          emailfield,
                          SizedBox(
                            height: 20,
                          ),
                          signUPButton,
                          SizedBox(
                            height: 20,
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
