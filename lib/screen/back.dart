import 'package:flutter/material.dart';

class Back extends StatelessWidget {
  const Back({
    super.key,
    required this.isSignupScreen,
  });

  final bool isSignupScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    isSignupScreen ? 'images/foot.jpg' : 'images/earth01.png'),
                fit: BoxFit.fill),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 120, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Welcome',
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 25,
                          color: Colors.white),
                      children: [
                        TextSpan(
                          text: isSignupScreen ? ' To Yummy Chat' : '  Back',
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        )
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  isSignupScreen
                      ? 'Signup to continue'
                      : 'SignIn to Continue ~~~',
                  style: TextStyle(
                      letterSpacing: 1.0, fontSize: 25, color: Colors.amber),
                )
              ],
            ),
          ),
        ));
  }
}
