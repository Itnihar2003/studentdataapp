import 'package:dataapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {
  const home({super.key, required this.email2});
  
  final String email2;
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController name = TextEditingController();
  TextEditingController roll = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController editname = TextEditingController();
  TextEditingController editroll = TextEditingController();
  TextEditingController editnumber = TextEditingController();
  bool operation = true;
  bool operation1 = false;

  pop() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "exit",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 86, 8, 70)),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () {
                              String savedname = name.text.toString();
                              String savedroll = roll.text.toString();
                              String savednumber = number.text.toString();

                              name.clear();
                              roll.clear();
                              number.clear();
                              if (savedname != "" &&
                                  savedroll != "" &&
                                  savednumber != "") {
                                FirebaseDatabase.instance
                                    .ref(widget.email2)
                                    .child(savedname)
                                    .set({
                                  "condition": operation,
                                  "name": savedname,
                                  "roll": savedroll,
                                  "number": savednumber
                                });

                                Navigator.pop(context);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    title: Center(
                                      child: Text(
                                        "please fill all",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ).timeout(const Duration(seconds: 1),
                                    onTimeout: () {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: const Text(
                              "save",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 86, 8, 70)),
                            )),
                      ],
                    ),
                  )
                ],
                content: SizedBox(
                  height: 270,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          TextField(
                            controller: name,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                hintText: "enter name:",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: roll,
                            decoration: const InputDecoration(
                                hintText: "enter rollno:",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: number,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: "enter phonenumber:",
                                border: OutlineInputBorder()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                title: const Text(
                  "Enter data",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 86, 8, 70)),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(),
                        ));
                  },
                  child: const Text(
                    "Sign out",
                    style: TextStyle(
                        color: Color.fromARGB(255, 86, 8, 70),
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
          backgroundColor: const Color.fromARGB(255, 86, 8, 70),
          title: const Text(
            "Student Data ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.amber, fontSize: 25),
          )),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance.ref(widget.email2),
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.child("condition").value != false) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          trailing: PopupMenuButton(
                            color: Colors.amber,
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      FirebaseDatabase.instance
                                          .ref(widget.email2)
                                          .child(snapshot
                                              .child("name")
                                              .value
                                              .toString())
                                          .update({"condition": operation1});
                                    },
                                    child: const ListTile(
                                        title: Text("Delete"),
                                        leading: Icon(Icons.delete)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .amber),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            "cancel",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        86,
                                                                        8,
                                                                        70)),
                                                          )),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .amber),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            if (editroll.text
                                                                        .toString() !=
                                                                    "" &&
                                                                editnumber.text
                                                                        .toString() !=
                                                                    "") {
                                                              FirebaseDatabase
                                                                  .instance
                                                                  .ref(widget
                                                                      .email2)
                                                                  .child(snapshot
                                                                      .child(
                                                                          "name")
                                                                      .value
                                                                      .toString())
                                                                  .update({
                                                                "roll": editroll
                                                                    .text
                                                                    .toString(),
                                                                "number":
                                                                    editnumber
                                                                        .text
                                                                        .toString()
                                                              });
                                                              editname.clear();
                                                              editroll.clear();
                                                              editnumber
                                                                  .clear();
                                                            } else {
                                                              Get.snackbar(
                                                                  "Error",
                                                                  "please fill both Rollno and number",
                                                                  backgroundColor:
                                                                      const Color
                                                                          .fromRGBO(
                                                                          255,
                                                                          193,
                                                                          7,
                                                                          1),
                                                                  colorText: const Color
                                                                      .fromARGB(
                                                                          255,
                                                                          86,
                                                                          8,
                                                                          70));
                                                            }
                                                          },
                                                          child: const Text(
                                                            "update",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        86,
                                                                        8,
                                                                        70)),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                                content: SizedBox(
                                                  height: 270,
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller: editroll,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                "Reenter rollno:",
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextField(
                                                        controller: editnumber,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                "Reenter phonenumber:",
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                title: const Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 86, 8, 70)),
                                                ),
                                              ));
                                    },
                                    child: const ListTile(
                                        title: Text("Edit"),
                                        leading: Icon(Icons.edit)),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          leading: const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 86, 8, 70),
                            child: Icon(
                              Icons.person,
                              color: Colors.amber,
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rollno=${snapshot.child("roll").value}"),
                              Text("Phone number=${snapshot.child("number").value}")
                            ],
                          ),
                          tileColor: const Color.fromARGB(255, 218, 183, 214),
                          title: Text("Name=${snapshot.child("name").value}")),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        trailing: PopupMenuButton(
                          iconColor: Colors.amber,
                          color: Colors.amber,
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    FirebaseDatabase.instance
                                        .ref(widget.email2)
                                        .child(snapshot
                                            .child("name")
                                            .value
                                            .toString())
                                        .update({"condition": operation});
                                  },
                                  child: const ListTile(
                                      title: Text("Restore"),
                                      leading: Icon(Icons.restart_alt)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    FirebaseDatabase.instance
                                        .ref(widget.email2)
                                        .child(snapshot
                                            .child("name")
                                            .value
                                            .toString())
                                        .remove();
                                  },
                                  child: const ListTile(
                                      title: Text("permanent Delete"),
                                      leading: Icon(Icons.delete)),
                                ),
                              ],
                            ))
                          ],
                        ),
                        tileColor: const Color.fromARGB(255, 86, 8, 70),
                        title: const Text(
                          "Temporartily deleted but you can restore it",
                          style: TextStyle(color: Colors.amber, fontSize: 15),
                        ),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 86, 8, 70),
        onPressed: () {
          pop();
        },
        child: const Icon(
          Icons.add,
          color: Colors.amber,
          size: 35,
        ),
      ),
    );
  }
}
