import 'package:dataapp/createaccount.dart';
import 'package:dataapp/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatelessWidget {
  login({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController pasward = TextEditingController();

  void save(BuildContext context) async {
    String savedemail = email.text.toString();
    String savedpasward = pasward.text.toString();
    email.clear();
    pasward.clear();
    if (savedemail == "" || savedpasward == "") {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "Error",
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ).timeout(const Duration(seconds: 1),
                                    onTimeout: () {
                                  Navigator.pop(context);
                                });
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: savedemail, password: savedpasward);

        if (userCredential != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => home(email2: savedpasward,),
              ));
        }
      } on FirebaseAuthException catch (ex) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              ex.code.toString(),
              style: const TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: ListView(children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Login Now",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Please register with email and signup to\n continue using our app",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 35,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter via Social Networks",
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 86, 8, 70)),
                  onPressed: () {
                    save(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "or login with\n E-mail",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: pasward,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "passward",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Passward?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 86, 8, 70)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => account()));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "create account",
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          const Row(
            children: [
              Text(
                "Donot have an account ?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Create account",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
