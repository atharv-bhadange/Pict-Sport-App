import 'package:flutter/material.dart';
import 'package:psa/screens/Home/home_screen.dart';
import 'package:psa/screens/login_signUp/userInfo_screen.dart';
import 'package:psa/services/authentication.dart';
import 'package:psa/services/getUserData.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              // color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Create an Account",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[50],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Email",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          // color: Colors.black87
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        validator: (val) {
                                          if (val!.length > 40) {
                                            return "Email cannot be that long";
                                          }
                                        },
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.email),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                        onChanged: (value) {
                                          email = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Password",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          // color: Colors.black87
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        validator: (val) {
                                          if (val!.length > 25) {
                                            return "Password Cannot be that long";
                                          } else
                                            return null;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.lock),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                        onChanged: (value) {
                                          password = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              padding: const EdgeInsets.only(top: 3, left: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: const Border(
                                      bottom: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black))),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    Authentication()
                                        .signUp(
                                        email: email, password: password)
                                        .then(
                                          (result) {
                                        if (result == null) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomeScreen()/*()UserInfo()*/,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                result,
                                                style: const TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                                color: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        InkWell(
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: const Divider(
                        thickness: 5,
                      ),
                    ),
                     const Padding(
                      padding: EdgeInsets.all(8.0),
                       child: Text(
                         "OR sign-in using",
                         style: TextStyle(
                           fontSize: 15,
                         ),
                       ),
                     ),
                     const SizedBox(
                       height: 5,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         IconButton(
                           onPressed: () {
                             Authentication()
                                 .signInWithGoogle()
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
                                         builder: (context) => HomeScreen()/*UserInfo()*/));
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
                           icon: Image.asset(
                             "assets/google.png",
                             height: 50,
                           ),
                         ),
                         /*IconButton(
                           onPressed: () {
                             AuthenticationHelper().microsoftSignIn(
                                 "microsoft.com",
                                 ["email openid"],
                                 {'language': 'en'}).then((result) {
                               if (result == false) {
                                 Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => GetUserData()));
                               } else if (result == true) {
                                 Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => UserInfo()));
                               } else {
                                 ScaffoldMessenger.of(context)
                                     .showSnackBar(SnackBar(
                                   content: Text(
                                     result,
                                     style: TextStyle(fontSize: 16),
                                   ),
                                 ));
                               }
                             });
                           },
                           icon: Image.asset(
                             "assets/icons/microsoft1.png",
                             height: 50,
                           ),
                         ),*/
                       ],
                     ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

