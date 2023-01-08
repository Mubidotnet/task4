import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fyp/homepage.dart';
import 'package:fyp/jobseeker.dart';
import 'package:fyp/roleofuser.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';

class profileScreen extends StatefulWidget {
  final String email;
  final String password;
  const profileScreen({super.key, required this.email, required this.password});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  String? gender;
  String regionCode = "PK";
  TextEditingController _date = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController skillsController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    setState(() {
      regionCode = countryCode.code.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Create Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: fnameController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.purple,
                        ),
                      ),
                      hintText: "First Name",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lnameController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.purple,
                        ),
                      ),
                      hintText: "Last Name",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
               
            
                Row(
                  children: [
                    CountryCodePicker(
                      onChanged: _onCountryChange,
                      initialSelection: 'PAKISTAN',
            
                      // showCountryOnly: false,
                      // showOnlyCountryWhenClosed: false,
                      favorite: ['+92', 'PAK'],
                      enabled: true,
                      hideMainText: true,
                      showFlagMain: true,
                      showFlag: true,
                      hideSearch: false,
                      showFlagDialog: false,
                      alignLeft: true,
                      padding: EdgeInsets.all(13.0),
                    ),
                    Container(
                      height: 25,
                      width: 220,
                      //color: Colors.amber,
                      child: TextFormField(
                        controller: numController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Phone Number',
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  //height: 30,
                  //width: 300,
                  //color: Colors.amber,
                  child: TextField(
                    controller: _date,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: 'D.O.B',
                    ),
                    onTap: () async {
                      DateTime? pickedddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickedddate != null) {
                        setState(() {
                          _date.text = DateFormat('dd-MM-yyyy').format(pickedddate);
                        });
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (Value) {
                        setState(() {
                          gender = Value.toString();
                        });
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Male',
                      style: TextStyle(color: Colors.black),
                    ),
                    Radio(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (Value) {
                        setState(() {
                          gender = Value.toString();
                        });
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Female',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                  width: 250,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: addressController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.purple,
                        ),
                      ),
                      hintText: "Home Address",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
            
                SizedBox(
                  height: 10,
                ),
                Container(
                  //height: 30,
                  //width: 300,
                  //color: Colors.amber,
                  child: TextField(
                    controller: educationController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Education",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  
                ),
                SizedBox(
                  height: 10,
                ),
            
                Container(
                 
                  child:
                    
                      TextField(
                    controller: skillsController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Skills",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w700),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () async {
                            PhoneNumberUtil plugin = PhoneNumberUtil();
                            String springFieldUSASimpleNoRegion =
                                numController.text;
                            RegionInfo region = const RegionInfo(
                                code: 'PK', name: 'Pakistan', prefix: 92);
                            bool isValid = await plugin.validate(
                                  springFieldUSASimpleNoRegion,
                                  regionCode: regionCode);
                            print(regionCode);
            
                            var snackdemo;
            
                            if (fnameController.text == "") {
                              snackdemo = SnackBar(
                                content: Text('Name Field cannot be empty!'),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                            } else if (lnameController.text == "") {
                              snackdemo = SnackBar(
                                content: Text('Name Field cannot be empty!'),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                            } else if (numController.text == "") {
                              snackdemo = SnackBar(
                                content: Text('Number Field cannot be empty!'),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                            } else if (addressController.text == "") {
                              snackdemo = SnackBar(
                                content:
                                    const Text('Address Field cannot be empty!'),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                            } else if (educationController.text == "") {
                              snackdemo = SnackBar(
                                content: Text('Education Field cannot be empty!'),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                            } else if (skillsController.text == "") {
                              snackdemo = SnackBar(
                                content: Text('Skills Field cannot be empty!'),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                            } else {
                              if (isValid) {
                                snackdemo = SnackBar(
                                  content: Text('Account Created Successfully!'),
                                  backgroundColor: Colors.green,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackdemo);
                                registerUserWithEmailAndPassword(
                                        widget.email, widget.password)
                                    .then((value) {
                                  saveEmailToFirestore(
                                          widget.email,
                                          fnameController.text,
                                          lnameController.text,
                                          numController.text,
                                          gender.toString(),
                                          addressController.text,
                                          educationController.text,
                                          skillsController.text)
                                      .then((value) {
                                        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
                                          builder: (context) => userRoles()),
                                          (Route<dynamic> route) => false,);
                                   // Navigator.of(context).push(MaterialPageRoute(
                                     //   builder: (context) => userRoles()));
                                  });
                                });
                              } else {
                                snackdemo = SnackBar(
                                content: Text('Invalid Phone Number!'),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                              }
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                          )),
                    )
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser?> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Save email to Firebase
  Future<void> saveEmailToFirebase(String email) async {
    FirebaseUser user = await _auth.currentUser();
    await user.updateEmail(email);
  }

// Save email to Firestore
  Future<void> saveEmailToFirestore(
      String email,
      String fname,
      String lname,
      String number,
      String gender,
      String address,
      String education,
      String skills) async {
    FirebaseUser user = await _auth.currentUser();
    await Firestore.instance.collection('users').document(user.uid).setData({
      'email': email,
      'first_name': fname,
      'last_name': lname,
      'number': number,
      'gender': gender,
      'address': address,
      'education': education,
      'skills': skills,
      'joining_date': DateTime.now().millisecondsSinceEpoch
    });
  }
}
