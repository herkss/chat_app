import 'package:chatting_test/screen/chat_screen.dart';

import 'package:flutter/material.dart';

import '../config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'back.dart';


class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  bool showSpinner = false;
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                Back(isSignupScreen: isSignupScreen),
                AnimatedPositioned(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeIn,
                    top: 280,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                      padding: EdgeInsets.all(20),
                      height: isSignupScreen ? 280 : 220,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 40,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignupScreen = false;
                                    });
                                  },
                                  child: Column(children: [
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: !isSignupScreen
                                              ? Palette.activeColor
                                              : Palette.textColor1),
                                    ),
                                    if (!isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      )
                                  ]),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignupScreen = true;
                                    });
                                  },
                                  child: Column(children: [
                                    Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: isSignupScreen
                                              ? Palette.activeColor
                                              : Palette.textColor1),
                                    ),
                                    if (isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      )
                                  ]),
                                ),
                              ],
                            ),
                            if (isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        keyboardType: TextInputType.emailAddress,
                                        key: ValueKey(1),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 4) {
                                            return 'Plaese Enter at least 4 characters';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userName = value!;
                                        },
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            hintText: 'User Name',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      //--------------------
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        key: ValueKey(2),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.contains('@')) {
                                            return 'Plaese Email adredd type input';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userEmail = value!;
                                        },
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            hintText: 'User Email',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      //----------------------------
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        //암호를 보이지않게 점으로 표시
                                        key: ValueKey(3),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return 'Password Enter at least 6 characters long';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userPassword = value!;
                                        },
                                        onChanged: (value) {
                                          userPassword = value;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock_open,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            hintText: 'User Password',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            //---------------------LOGIN TEXTFORM---------------
                            if (!isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        key: ValueKey(4),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 4) {
                                            return 'Plaese Enter at least 4 characters';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userName = value!;
                                        },
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            hintText: 'User Name',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      //--------------------
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        key: ValueKey(5),
                                        // 텍스트폼필드의 고유의 값을 가져 필드의 값들이 뒤섞이지않게 함
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 4) {
                                            return 'Plaese Enter at least 4 characters';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          userPassword = value!;
                                        },
                                        onChanged: (value) {
                                          userPassword = value;
                                        },

                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock_clock_rounded,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Palette.textColor1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular((35)))),
                                            hintText: 'User Password',
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                      //--------------------
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    )), // 텍스트폼 필드
                AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: isSignupScreen ? 530 : 470,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              showSpinner = true;
                            });


                            if (isSignupScreen) {
                              _tryValidation();
                              try {
                                final newUser = await _authentication
                                    .createUserWithEmailAndPassword(
                                    email: userEmail, password: userPassword);

                                await FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set(
                                    {'userName' : userName,
                                      'email': userEmail});


                                if (newUser.user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const ChatScreen();
                                    }),
                                  );

                                  setState(() {
                                    showSpinner = false;
                                  });

                                }
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please Check your Email and Password'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              }
                            }



                            if (!isSignupScreen) {
                              _tryValidation();


                              try {
                                final newUser = await _authentication
                                    .signInWithEmailAndPassword(
                                    email: userEmail, password: userPassword);

                                if (newUser.user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const ChatScreen();
                                    }
                                    ),
                                  );
                                }
                              }catch(e){
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please Check your Email and Password'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              }
                              }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.orange, Colors.red],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(3, 4)),
                                ]),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )), //전송버튼
                AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: isSignupScreen
                        ? MediaQuery
                        .of(context)
                        .size
                        .height - 125
                        : MediaQuery
                        .of(context)
                        .size
                        .height - 165,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        Text(isSignupScreen
                            ? "or Signup With"
                            : "OR SIGN IN WITH"),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                minimumSize: Size(155, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Palette.googleColor),
                            icon: Icon(Icons.add),
                            label: Text('GOOGLE'))
                      ],
                    )), //구글로그인버튼
              ],
            ),
          ),
        );
  }
}
