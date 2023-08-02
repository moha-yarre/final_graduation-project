// import 'package:final_project/admin%20page/adminpage.dart';
import 'package:flutter/material.dart';
import 'package:graduation_projects/adminpases/SuperVisorhomepage.dart';
// import 'package:graduation_projects/adminpases/SuperVisorView.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';
// import 'package:final_project/screens/registrationscreen.dart';
// import 'package:final_project/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_projects/adminpases/supervisor.dart';
import 'package:graduation_projects/screens/homepage.dart';
import 'package:graduation_projects/screens/registrationscreen.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;

//editing controller
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwrodcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailfield = TextFormField(
      // validator: (value) {

      //   if (value.toString().trim().isEmpty) {
      //     return 'gmail is required';
      //   }
      // },
      validator: (value) {
        print(value);
        if (value!.isEmpty) {
          return "Please Enter Email";
        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return "Please Enter a Valid Email";
        }
        return null;
      },

      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "Email"),
    );
    final passwordfield = TextFormField(
      validator: (value) {
        if (value.toString().trim().isEmpty) {
          return 'password required';
        }
        if (value.toString().length < 6) {
          return 'enter at least 6 character';
        }
      },
      autofocus: false,
      obscureText: true,
      controller: passwrodcontroller,
      onSaved: (value) {
        passwrodcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "password"),
    );
    final buttonfield = Material(
      color: Colors.purple[800],
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              final loggedUser = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailcontroller.text,
                      password: passwrodcontroller.text);

              // print(loggedUser.user!.email);
              if (loggedUser.user != null) {
                await for (var m
                    in _firestore.collection('users').snapshots()) {
                  for (var snap in m.docs) {
                    // var email=
                    var name = snap.get('fname');
                    var isAdmin = snap.get('email');
                    if (isAdmin == emailcontroller.text) {
                      var isadmin = snap.get('isAdmin');
                      var isSuperVisor = snap.get('isSuperVisor');
                      // print(isadmin);
                      if (isadmin == false && isSuperVisor == false) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return home();
                          },
                        ));
                      } else if (isadmin == true && isSuperVisor == false) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return adminpage();
                          },
                        ));
                      } else if (isadmin == false && isSuperVisor == true) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SuperVisorView(
                              currentLoggedIn: name,
                            );
                          },
                        ));
                      }
                    } else {
                      print('Unknow');
                    }
                    // print('isADmin:$isAdmin');
                  }
                }
              }
            }
          },
          child: Text(
            "login",
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
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 98.0),
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("images/simadlogo.png"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        emailfield,
                        SizedBox(
                          height: 10,
                        ),
                        passwordfield,
                        SizedBox(
                          height: 10,
                        ),
                        buttonfield,
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "you don'n have an account",
                              style: TextStyle(fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          registrationscreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "signUP",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.purple[800]),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
