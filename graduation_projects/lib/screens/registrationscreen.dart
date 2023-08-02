import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:final_project/screens/loginscreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_projects/screens/loginscreen.dart';

class registrationscreen extends StatefulWidget {
  const registrationscreen({super.key});

  @override
  State<registrationscreen> createState() => _registrationscreenState();
}

class _registrationscreenState extends State<registrationscreen> {
  final _formkey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  // editing
  final firtsnameeditingcontroller = new TextEditingController();
  final secondnameeditincontroller = new TextEditingController();
  final emaleditingcontroller = new TextEditingController();
  final phoneeditingcontroller = new TextEditingController();
  final passwordeditingcontroller = new TextEditingController();
  final confirmpasswordeditingcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // first name field Halkan waa ka sameeyey fucntion first name ka
    final firstfield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter first name';
        }
      },
      autofocus: false,

      controller: firtsnameeditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        firtsnameeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "first name"),
      // maxLines: 2,
    );

    final secondnamefield = TextFormField(
      validator: (value) {
        if (passwordeditingcontroller.text !=
            confirmpasswordeditingcontroller.text) {
          return 'Enter second name';
        }
      },
      autofocus: false,
      controller: secondnameeditincontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        secondnameeditincontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "second name"),
    );
    // phone field
    final phonefield = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter phone';
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'please Enter  email';
          }
          if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
              .hasMatch(value)) {
            return 'please inter valid email, your gmail must contain @, .';
          }
        });

    final passwordfield = TextFormField(
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter password';
        }
      },
    );

    final confirmfield = TextFormField(
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
      validator: (value) {
        // return 'Fadlan password saxan gali';
        if (passwordeditingcontroller.text !=
            confirmpasswordeditingcontroller.text) {
          return 'Password ka iskumid ma ahan';
        }
      },
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
              final fireAuth = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emaleditingcontroller.text,
                      password: passwordeditingcontroller.text);
              // if(fireAuth)
              // print(fireAuth.user);
              if (fireAuth.user != null) {
                _firestore.collection('users').add({
                  'fname': firtsnameeditingcontroller.text,
                  'lname': secondnameeditincontroller.text,
                  'email': emaleditingcontroller.text,
                  'pass': passwordeditingcontroller.text,
                  'phone': phoneeditingcontroller.text,
                  'isAdmin': false,
                  'isSuperVisor': false
                }).then((value) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return loginpage();
                    },
                  ));
                });
                //
              }
            }
            // print('dont touch me');
            // _firestore.app\
            // _firestores
          },
          child: Text(
            "signUP",
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
              "Registration page",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.purple[800],
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
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
                          firstfield,
                          SizedBox(
                            height: 20,
                          ),
                          secondnamefield,
                          SizedBox(
                            height: 20,
                          ),
                          phonefield,
                          SizedBox(
                            height: 20,
                          ),
                          emailfield,
                          SizedBox(
                            height: 20,
                          ),
                          passwordfield,
                          SizedBox(
                            height: 20,
                          ),
                          confirmfield,
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
