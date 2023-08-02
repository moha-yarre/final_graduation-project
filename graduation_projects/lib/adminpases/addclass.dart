import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';

class addclass extends StatefulWidget {
  const addclass({super.key});

  @override
  State<addclass> createState() => _addclassState();
}

class _addclassState extends State<addclass> {
  final _formkey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  // editing
  final classeditingcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final classfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter class name';
        }
      },
      autofocus: false,
      controller: classeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        classeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.class_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "class name"),
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
              _firestore.collection('class').add({
                'classname': classeditingcontroller.text,
              }).then((value) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return adminpage();
                  },
                ));
              });
              //
            }
            ;
          },
          // },
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
              "add new class",
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
                          classfield,
                          SizedBox(
                            height: 5,
                          ),
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
