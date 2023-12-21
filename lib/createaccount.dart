import 'package:dataapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class account extends StatefulWidget {
  account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  TextEditingController email = TextEditingController();

  TextEditingController pasward = TextEditingController();

  bool pop = false;

  void save(BuildContext context) async {
    String savedemail = email.text.toString();
    String savedpasward = pasward.text.toString();
    if (savedemail == "" || savedpasward == "") {
      print("error");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: savedemail, password: savedpasward);
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text(
              "saved successfully",
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
        if (userCredential != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => login(),
              ));
        }
      } on FirebaseAuthException catch (ex) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              ex.code.toString(),
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
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
          "Sign up",
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    "lib/image/lo.png",
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("lib/image/lo2.png"),
                ),
              ],
            ),
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
            Row(
              children: [
                Checkbox(
                    activeColor: const Color.fromARGB(255, 86, 8, 70),
                    checkColor: Colors.amber,
                    value: pop,
                    onChanged: (newpop) {
                      setState(() {
                        pop = newpop!;
                      });
                    }),
                const Text(
                  "I agree with privacy policy",
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
              save(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => login()));
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
          height: 30,
        ),
        Row(
          children: [
            const Text(
              "You already have an account ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.amber),
                ))
          ],
        ),
      ]),
    ));
  }
}
