import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
// import 'package:graduation_projects/adminpases/SuperVisorView.dart';
import 'package:graduation_projects/adminpases/adding_project.dart';
import 'package:graduation_projects/adminpases/adminpage.dart';

class veiwsupervisor extends StatefulWidget {
  const veiwsupervisor({super.key});

  @override
  State<veiwsupervisor> createState() => _veiwsupervisorState();
}

class _veiwsupervisorState extends State<veiwsupervisor> {
  @override
  final _firestores = FirebaseFirestore.instance;

  var supname = TextEditingController();
  var supaddress = TextEditingController();
  var supphone = TextEditingController();
  var supemail = TextEditingController();
  var suppassword = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple[800],
          title: Text("all supervisors"),
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

        //
        //

        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestores.collection('users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Wax Baa qaldan");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Fadlan sug inyar');
              }
              final info = snapshot.data!.docs;
              final supervisorlist = [];
              var phonelist = [];
              var IDs = [];
              var emalist = [];
              // var addresslist = [];
              var passwordlist = [];

              for (var information in info) {
                var issuper1var = information.get('isSuperVisor');
                if (issuper1var) {
                  var namevar = information.get('fname');
                  var phonevar = information.get('phone');
                  // var addressvar = information.get('address');
                  var emailvar = information.get('email');
                  var passvar = information.get('pass');

                  IDs.add(information.id);

                  supervisorlist.add(namevar);
                  phonelist.add(phonevar);
                  emalist.add(emailvar);

                  passwordlist.add(passvar);
                }
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: supervisorlist.length,
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
                                      title: Text(supervisorlist[index]),
                                      // content: Text('GeeksforGeeks'),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(titleNames[index]),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Text(
                                          //   'project Description',
                                          //   style: TextStyle(
                                          //       fontWeight:
                                          //           FontWeight.bold),
                                          // ),
                                          // Text('${titleDesc[index]}')
                                          // _firestore.
                                          // var id=IDs[index]
                                        ],
                                      ),
                                      // actions: [
                                      //   TextButton(
                                      //     // textColor: Colors.black,
                                      //     onPressed: () {
                                      //       Navigator.pop(context);
                                      //     },
                                      //     child: Text('CANCEL'),
                                      //   ),
                                      //   TextButton(
                                      //     // textColor: Colors.black,
                                      //     onPressed: () {

                                      //     },
                                      //     child: Text('update'),
                                      //   ),
                                      // ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text('${supervisorlist[index]}')),
                        trailing: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  supname.text = supervisorlist[index];
                                  supphone.text = phonelist[index];
                                  // supaddress.text = addresslist[index];
                                  supemail.text = emalist[index];
                                  suppassword.text = passwordlist[index];
                                });
                                // usig show diolog ba
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: AlertDialog(
                                        // title: Text('Welcome'),
                                        content: SingleChildScrollView(

                                            // child: Column(
                                            //   // shrinkWrap: true,
                                            //   children: [

                                            // TextFormField(
                                            //   controller: supname,
                                            //   decoration: InputDecoration(
                                            //       label: Text(' sup name')),
                                            // ),
                                            // SizedBox(height: 5),
                                            // TextFormField(
                                            //   controller: supphone,
                                            //   decoration: InputDecoration(
                                            //       label: Text('phone')),
                                            // ),
                                            // SizedBox(height: 5),
                                            // // TextFormField(
                                            // //   controller: supaddress,
                                            // //   decoration: InputDecoration(
                                            // //       label: Text('address')),
                                            // // ),
                                            // SizedBox(height: 5),
                                            // TextFormField(
                                            //   controller: supemail,
                                            //   decoration: InputDecoration(
                                            //       label: Text('email')),
                                            // ),
                                            // SizedBox(height: 5),
                                            // TextFormField(
                                            //   controller: suppassword,
                                            //   decoration: InputDecoration(
                                            //       label: Text('password')),
                                            // ),
                                            // SizedBox(height: 5),
                                            //   ],
                                            // ),
                                            ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return veiwsupervisor();
                                                  },
                                                ));
                                              },
                                              child: Text("cancel")),
                                          ElevatedButton(
                                              // child: Text('cancce'),
                                              onPressed: () {
                                                _firestores
                                                    .collection('users')
                                                    .doc(IDs[index])
                                                    .update({
                                                  'fname': supname.text,
                                                  'phone': supphone.text,
                                                  // 'address':
                                                  //     supaddress.text,
                                                  'email': supemail.text,
                                                }).then((value) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return addingpage(
                                                          // tappedName: widget
                                                          //     .tappedName,
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
                                    .collection('users')
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
        ),
      ),
    );
  }
}











            // 
            // 

//             body: SafeArea(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestores.collection('users').snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasError) {
//                     return Text("Wax Baa qaldan");
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Text('Fadlan sug inyar');
//                   }
//                   final info = snapshot.data!.docs;
//                   // final titleNames = [];
//                   var supervisorlist = [];
//                   var addresslist = [];
//                   var phonelist = [];
//                   var emaillist = [];
//                   var IDs = [];
//                   var passlist = [];

//                   for (var information in info) {
//                     var issuper1var = information.get('isSuperVisor');
//                     if (issuper1var) {
//                       var namevar = information.get('fname');

//                       var addressvar = information.get('address');
//                       var phonevar = information.get('phone');
//                       var emailvar = information.get('email');
//                       var passvar = information.get('pass');

//                       IDs.add(information.id);

//                       supervisorlist.add(namevar);

//                       addresslist.add(addressvar);
//                       phonelist.add(phonevar);
//                       emaillist.add(emailvar);
//                       passlist.add(passvar);
//                     }
//                   }
//                   return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: supervisorlist.length,
//                       itemBuilder: ((context, index) {
//                         return Container(
//                           margin: EdgeInsets.only(left: 10, right: 10, top: 10),
//                           child: ListTile(
//                             title: Text(supervisorlist[index]),
//                             leading: CircleAvatar(child: Text("$index")),
//                             trailing: Column(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       supname.text = supervisorlist[index];
//                                       supaddress.text = addresslist[index];
//                                       supphone.text = phonelist[index];
//                                       suppassword.text = passlist[index];
//                                       supemail.text = emaillist[index];
//                                     });
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return SafeArea(
//                                           child: AlertDialog(
//                                             content: SingleChildScrollView(
//                                               child: Column(
//                                                 children: [
//                                                   TextFormField(
//                                                     controller: supname,
//                                                     decoration: InputDecoration(
//                                                         label: Text(
//                                                             'supervisor name')),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   TextFormField(
//                                                     controller: supaddress,
//                                                     decoration: InputDecoration(
//                                                         label:
//                                                             Text(' address')),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   TextFormField(
//                                                     controller: supemail,
//                                                     decoration: InputDecoration(
//                                                         label: Text(' email')),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   TextFormField(
//                                                     controller: supphone,
//                                                     decoration: InputDecoration(
//                                                         label: Text(' phone')),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   TextFormField(
//                                                     controller: supaddress,
//                                                     decoration: InputDecoration(
//                                                         label:
//                                                             Text(' password')),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                 ],
//                                               ),
//                                             ),
//                                             actions: [
//                                               ElevatedButton(
//                                                   onPressed: () {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) {
//                                                           return veiwsupervisor();
//                                                         },
//                                                       ),
//                                                     );
//                                                   },
//                                                   child: Text("cancel")),
//                                               ElevatedButton(
//                                                   onPressed: () {
//                                                     _firestores
//                                                         .collection('users')
//                                                         .doc(IDs[index])
//                                                         .update({
//                                                       'fname': supname.text,
//                                                       'address':
//                                                           supaddress.text,
//                                                       'phone': supphone.text,
//                                                       'email': supemail.text,
//                                                       'pass': suppassword.text
//                                                     })
//                                                       ..then((value) {
//                                                         Navigator.push(context,
//                                                             MaterialPageRoute(
//                                                           builder: (context) {
//                                                             return veiwsupervisor();
//                                                           },
//                                                         ));
//                                                       });
//                                                   },
//                                                   child: Text("update")),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   child: Icon(
//                                     Icons.edit,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     // Delete
//                                     _firestores
//                                         .collection('users')
//                                         .doc(IDs[index])
//                                         .delete();
//                                     print('dont delete m..e');
//                                   },
//                                   child: Icon(
//                                     Icons.remove_circle_outline,
//                                     color: Colors.red,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),

//                           // child: ListTile(
//                           //   // leading: CircleAvatar(
//                           //   // child: Text('$index'),
//                           //   // ),
//                           //   title: GestureDetector(
//                           //     onTap: () {
//                           //       showDialog(
//                           //         context: context,
//                           //         builder: (BuildContext context) {
//                           //           return Expanded(
//                           //             child: AlertDialog(
//                           //               title: Text(namess[index]),
//                           //               // content: Text('GeeksforGeeks'),
//                           //               content: Column(
//                           //                 crossAxisAlignment:
//                           //                     CrossAxisAlignment.start,
//                           //                 children: [
//                           //                   // Text(titleNames[index]),
//                           //                   SizedBox(
//                           //                     height: 10,
//                           //                   ),
//                           //                   Text(
//                           //                       'Project gaan waxaa loo assign gareeyay ardayda kala ah  ${namess[index]} iyo ${emails[index]}'),
//                           //                   Text(
//                           //                     'project Description',
//                           //                     style: TextStyle(
//                           //                         fontWeight: FontWeight.bold),
//                           //                   ),
//                           //                   Text('${addres[index]}')
//                           //                   // _firestore.
//                           //                   // var id=IDs[index]
//                           //                 ],
//                           //               ),
//                           //               // actions: [
//                           //               //   TextButton(
//                           //               //     // textColor: Colors.black,
//                           //               //     onPressed: () {
//                           //               //       Navigator.pop(context);
//                           //               //     },
//                           //               //     child: Text('CANCEL'),
//                           //               //   ),
//                           //               //   TextButton(
//                           //               //     // textColor: Colors.black,
//                           //               //     onPressed: () {

//                           //               //     },
//                           //               //     child: Text('update'),
//                           //               //   ),
//                           //               // ],
//                           //             ),
//                           //           );
//                           //         },
//                           //       );
//                           //     },
//                           //     // child: Text('${titleNames[index]}')
//                           //   ),
//                           //   subtitle: Text('${namess[index]}'),
//                           //   trailing: Column(
//                           //     children: [
//                           //       GestureDetector(
//                           //         onTap: () {
//                           //           setState(() {
//                           //             sname.text = namess[index];
//                           //             addr.text = addres[index];
//                           //             phone.text = phon[index];
//                           //             passw.text = passlist[index];
//                           //             // desc.text = titleDesc[index];
//                           //             // focult.text = foculty[index];
//                           //             // batchs.text = batc[index];
//                           //             // programs.text = progr[index];
//                           //             // supervisors.text = superVsor[index];
//                           //             // startdates.text = startd[index];
//                           //             // ensdates.text = endd[index];
//                           //           });
//                           //           // usig show diolog ba
//                           //           showDialog(
//                           //             context: context,
//                           //             builder: (BuildContext context) {
//                           //               return SafeArea(
//                           //                 child: AlertDialog(
//                           //                   // title: Text('Welcome'),
//                           //                   content: SingleChildScrollView(
//                           //                     child: Column(
//                           //                       // shrinkWrap: true,
//                           //                       children: [
//                           //                         TextFormField(
//                           //                           controller: sname,
//                           //                           decoration: InputDecoration(
//                           //                               label: Text(
//                           //                                   'supervisor name')),
//                           //                         ),
//                           //                         SizedBox(height: 5),
//                           //                         TextFormField(
//                           //                           controller: addr,
//                           //                           decoration: InputDecoration(
//                           //                               label: Text('address')),
//                           //                         ),
//                           //                         SizedBox(height: 5),
//                           //                         TextFormField(
//                           //                           controller: phone,
//                           //                           decoration: InputDecoration(
//                           //                               label: Text('phone')),
//                           //                         ),
//                           //                         SizedBox(height: 5),
//                           //                         TextFormField(
//                           //                           controller: email,
//                           //                           decoration: InputDecoration(
//                           //                               label: Text('email')),
//                           //                         ),
//                           //                         TextFormField(
//                           //                           controller: passw,
//                           //                           decoration: InputDecoration(
//                           //                               label:
//                           //                                   Text('password')),
//                           //                         ),
//                           //                         TextFormField(
//                           //                             //   controller: batchs,
//                           //                             //   decoration: InputDecoration(
//                           //                             //       label: Text('batch')),
//                           //                             // ),
//                           //                             // TextFormField(
//                           //                             //   controller: supervisors,
//                           //                             //   decoration: InputDecoration(
//                           //                             //       label:
//                           //                             //           Text('supervisor')),
//                           //                             // ),
//                           //                             // TextFormField(
//                           //                             //   controller: title,
//                           //                             //   decoration: InputDecoration(
//                           //                             //       label: Text(
//                           //                             //           'title project')),
//                           //                             // ),
//                           //                             // TextFormField(
//                           //                             //   controller: desc,
//                           //                             //   decoration: InputDecoration(
//                           //                             //       label: Text(
//                           //                             //           'title description')),
//                           //                             // ),
//                           //                             // TextFormField(
//                           //                             //   controller: startdates,
//                           //                             //   decoration: InputDecoration(
//                           //                             //       label:
//                           //                             //           Text('start date')),
//                           //                             // ),
//                           //                             // TextFormField(
//                           //                             //   controller: ensdates,
//                           //                             //   decoration: InputDecoration(
//                           //                             //       label: Text('enddate')),
//                           //                             ),
//                           //                       ],
//                           //                     ),
//                           //                   ),
//                           //                   actions: [
//                           //                     ElevatedButton(
//                           //                         onPressed: () {
//                           //                           _firestores
//                           //                               .collection(
//                           //                                   'table_supervisor')
//                           //                               .doc(IDs[index])
//                           //                               .update({
//                           //                             'sname': sname.text,
//                           //                             'address': addr.text,
//                           //                             'phone': phone.text,
//                           //                             'email': email.text,
//                           //                             // 'foculty': focult.text,
//                           //                             // 'batch': batchs.text,
//                           //                             // 'program': programs.text,
//                           //                             // 'supervisor':
//                           //                             //     supervisors.text,
//                           //                             // 'startDate':
//                           //                             //     startdates.text,
//                           //                             // 'endDate': ensdates.text
//                           //                           }).then((value) {
//                           //                             Navigator.push(context,
//                           //                                 MaterialPageRoute(
//                           //                               builder: (context) {
//                           //                                 return adminpage();
//                           //                               },
//                           //                             ));
//                           //                           });
//                           //                         },
//                           //                         child: Text('update'))
//                           //                   ],
//                           //                 ),
//                           //               );
//                           //             },
//                           //           );
//                           //         },
//                           //         child: Icon(
//                           //           Icons.edit,
//                           //           color: Colors.green,
//                           //         ),
//                           //       ),
//                           //       SizedBox(
//                           //         width: 4,
//                           //       ),
//                           //       GestureDetector(
//                           //         onTap: () {
//                           //           // Delete
//                           //           _firestores
//                           //               .collection('table_supervisor')
//                           //               .doc(IDs[index])
//                           //               .delete();
//                           //           print('dont delete me');
//                           //         },
//                           //         child: Icon(
//                           //           Icons.remove_circle_outline,
//                           //           color: Colors.red,
//                           //         ),
//                           //       )
//                           //     ],
//                           //   ),
//                           // ),
//                         );
//                       }));
//                 },
//               ),
//               // child:
//             )));
//   }
// }
