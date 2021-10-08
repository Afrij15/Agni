import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class Settingsuser extends StatefulWidget {
  final String documentId;

  Settingsuser(this.documentId);

  @override
  _SettingsuserState createState() => _SettingsuserState();
}

class _SettingsuserState extends State<Settingsuser> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('customer');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String name = data['name'];
          String email = data['email'];
          String address = data['address'];
          String phone = data['phone'];
          TextEditingController namecontroller =
              TextEditingController(text: name);
          TextEditingController emailcontroller =
              TextEditingController(text: email);
          TextEditingController addresscontroller =
              TextEditingController(text: address);
          TextEditingController phonecontroller =
              TextEditingController(text: phone);

          return Scaffold(
            appBar: AppBar(
              title: Text('User Info'),
              backgroundColor: Colors.pink[100],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a Name' : null,
                        decoration: textInputDecorforUpdate.copyWith(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.blue)),
                        controller: namecontroller,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        enabled: false,
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a Name' : null,
                        decoration: textInputDecorforUpdate.copyWith(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.blue)),
                        controller: emailcontroller,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a Name' : null,
                        decoration: textInputDecorforUpdate.copyWith(
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              color: Colors.blue,
                            )),
                        controller: addresscontroller,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a Name' : null,
                        decoration: textInputDecorforUpdate.copyWith(
                            labelText: 'Phone',
                            labelStyle: TextStyle(color: Colors.blue)),
                        controller: phonecontroller,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[200],
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          textStyle: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          setState(() {
                            name = namecontroller.text;
                            email = emailcontroller.text;
                            address = addresscontroller.text;
                            phone = phonecontroller.text;
                          });
                          FirebaseFirestore.instance
                              .collection('customer')
                              .doc(widget.documentId)
                              .update({
                            "name": name,
                            "email": email,
                            "address": address,
                            "phone": phone,
                          });
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Loading();
      },
    );
  }
}
