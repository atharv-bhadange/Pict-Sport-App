import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/screens/login_signUp/userInfo_screen.dart';
import 'package:psa/services/authentication.dart';
import 'package:psa/services/getUserData.dart';

class Background extends StatefulWidget {
  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  String misId = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset('assets/top1.png', width: width),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/top2.png", width: width),
          ),
          Positioned(
            top: 6,
            right: 0,
            child: SizedBox(
              // height: 35,width: 52,
              height: height* 0.21,
              width: height * 0.21,
              // child: Image.asset("assets/google.png",),
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_r7bfvyke.json'),
              //
            ),
          ),
          Positioned(
            top: height * 0.102,
            left: height * 0.04,
            child: SizedBox(
              height: height * 0.35,
              width: height * 0.3,
              child: const Text(
                "Welcome \tPict'ians",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: width * 0.15,
            child: Container(
              height: height * 0.50,
              width: height * 0.34,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo1.png'),
                ),
              ),
            ),
          ),
          Positioned(
              top: height * 0.61,
              left: width * 0.19,
              child: InkWell(
                onTap: (){print('kkk');
                Authentication().signInWithGoogle(context).then((result) {
                  if (result == false) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GetUserData()));
                  } else if (result == true) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserInfo()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        result,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                });
                },child: Container(
                height: height * 0.15,
                width:height * 0.30,
                decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(23),
                  border: Border.all(color: Colors.blueAccent, width: 3),
                ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                        width: 90,
                        child: Lottie.network(
                            'https://assets4.lottiefiles.com/private_files/lf30_29gwi53x.json'),
                      ),
                      const Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
              ),
              )),
          /*Positioned(
            top: height * 0.61,
            left: width * 0.19,
            child: GestureDetector(
              onTap: () async {
                print("123");
                await Authentication().signInWithGoogle(context).then((result) {
                  if (result == false) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GetUserData()));
                  } else if (result == true) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserInfo()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        result,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(23),
                    border: Border.all(color: Colors.blueAccent, width: 3),
                  ),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          print("euu");
                          await Authentication()
                              .signInWithGoogle(context)
                              .then((result) {
                            if (result == false) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GetUserData()));
                            } else if (result == true) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UserInfo()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  result,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ));
                            }
                          });
                        },
                        child: SizedBox(
                          height: 80,
                          width: 90,
                          child: Lottie.network(
                              'https://assets4.lottiefiles.com/private_files/lf30_29gwi53x.json'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          print("yuu");
                          await Authentication()
                              .signInWithGoogle(context)
                              .then((result) {
                            if (result == false) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GetUserData()));
                            } else if (result == true) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UserInfo()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  result,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ));
                            }
                          });
                        },
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  )
                  ),
            ),
          ),*/
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottom1.png", width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottom2.png", width: size.width),
          ),
        ],
      ),
    );
  }
}
