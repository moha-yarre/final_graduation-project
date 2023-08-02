import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';

class assignproject extends StatefulWidget {
  const assignproject({super.key});

  @override
  State<assignproject> createState() => _assignprojectState();
}

class _assignprojectState extends State<assignproject> {
  final _formkey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  String dropdownvalue = 'Choose Supervisor';
  String classdroplist = 'choose class ';
  String std2 = 'choose students2 ';

  var items = [
    'Choose Supervisor',
  ];
  ListSuperVisors() async {
    await for (var i in _firestore.collection('users').snapshots()) {
      for (var j in i.docs) {
        var isSuperVisor = j.get('isSuperVisor');
        if (isSuperVisor) {
          var name = j.get('fname');
          if (items.contains(name) != true) {
            setState(() {
              items.add(name);
              print(name);
            });
            // items.add(name);
            // print()
          }
        }
      }
    }
  }

  var itemm = [
    'Choose class',
  ];
  Listsclass() async {
    await for (var i in _firestore.collection('class').snapshots()) {
      for (var j in i.docs) {
        // var isSuperVisor = j.get('classname');
        // if (isSuperVisor) {
        var names = j.get('classname');
        if (itemm.contains(names) != true) {
          setState(() {
            itemm.add(names);
            print(names);
          });
          // items.add(name);
          // print()
          // }
        }
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    ListSuperVisors();
    // Liststudents();
    Listsclass();
    // ListSuperVisors1();
  }

  final studet1 = new TextEditingController();
  final student2 = new TextEditingController();
  final titlename = new TextEditingController();
  final titledesc = new TextEditingController();
  final phone = new TextEditingController();
  final clas = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentdropdown = Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
        value: dropdownvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
        },
      ),
    );

    final studentone = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter first name";
        }

        return null;
      },
      autofocus: false,

      controller: studet1,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        studet1.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "first student"),
      // maxLines: 2,
    );
    final studenttow = TextFormField(
      validator: (value) {
        // print(value);
        if (value!.isEmpty) {
          return "Please Enter second student";
        }

        return null;
      },

      autofocus: false,

      controller: student2,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        student2.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "second student"),
      // maxLines: 2,
    );
    final tittlenamae = TextFormField(
      validator: (value) {
        // print(value);
        if (value!.isEmpty) {
          return "Please Enter title name";
        }

        return null;
      },

      autofocus: false,

      controller: titlename,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        titlename.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.title_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "title name"),
      // maxLines: 2,
    );
    final phonenumber = TextFormField(
      validator: (value) {
        // print(value);
        if (value!.isEmpty) {
          return "enter phone number";
        }

        return null;
      },

      autofocus: false,

      controller: phone,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        phone.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "phone number"),
      // maxLines: 2,
    );
    final titledescription = TextFormField(
      validator: (value) {
        // print(value);
        if (value!.isEmpty) {
          return "Please Enter phone number";
        }

        return null;
      },

      autofocus: false,

      controller: titledesc,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        titledesc.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.description_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "title description"),
      // maxLines: 2,
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
              _firestore.collection('assignproject').add({
                'supervisor': dropdownvalue,
                'classname': classdroplist,
                'student1': studet1.text,
                'student2': student2.text,
                'titleName': titlename.text,
                'titledesc': titledesc.text,
                'groupNum': phone.text,
                'isAdmin': false,
                'isSuperVisor': false
              }).then((value) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return adminpage();
                  },
                ));
              });
              //
            }
          },
          child: Text(
            "register",
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
            "assign project",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purple[800],
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
                        SizedBox(
                          height: 5,
                        ),
                        studentdropdown,
                        SizedBox(height: 5),
                        // classdrop,
                        SizedBox(height: 5),
                        studentone,
                        SizedBox(height: 5),
                        studenttow,
                        SizedBox(height: 5),
                        tittlenamae,
                        SizedBox(height: 5),
                        titledescription,
                        SizedBox(height: 5),
                        phonenumber,
                        SizedBox(height: 5),
                        signUPButton,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
