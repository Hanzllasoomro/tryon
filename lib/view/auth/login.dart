import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryon/component/PrimaryButton.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/constant/app_images.dart';
import 'package:tryon/repository/auth_repo/firebase_auth_repository.dart';
import 'package:tryon/utils/utils.dart';
import 'package:tryon/view/auth/forget.dart';
import 'package:tryon/view/auth/signup.dart';
import 'package:tryon/view/navigation/admin_navigation.dart';
import 'package:tryon/view/navigation/navigation.dart';
import 'package:tryon/view_model/AuthController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthController authController = Get.put(
    AuthController(authRepo: FirebaseAuthRepository()),
  );

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  // void login() {
  //   _auth
  //       .signInWithEmailAndPassword(
  //         email: emailcontroller.text.toString(),
  //         password: passwordcontroller.text.toString(),
  //       )
  //       .then((value) {
  //         Utils().toastmessage(value.user!.email.toString());
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => Navigation()),
  //         );
  //       })
  //       .onError((error, stackTrace) {
  //         Utils().toastmessage(error.toString());
  //       });
  // }
//     void login() {

//       log(emailcontroller.text.trim());
//       log(passwordcontroller.text.trim());
//  _auth
//       .signInWithEmailAndPassword(
//         email: emailcontroller.text.trim(),
//         password: passwordcontroller.text.trim(),
//       )
//       .then((value) {
//         final userEmail = value.user!.email.toString();


// log(userEmail);
//         if (userEmail == "admin@gmail.com") {
//           // ✅ Admin login
//           log("in if");
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AdminNavigation()),
//           );  
//         } else {
//                  log("in else");
//           // ✅ Normal user login
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Navigation()),
//           );
//         }
//       })
//       .onError((error, stackTrace) {
//         Utils().toastmessage(error.toString());
//       });
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        // Makes the body scrollable
        child: Column(
          children: [
            // Image.asset(AppImages.appIcon,height: 300,width: 300,),
            SizedBox(
  height: 180,
  width: 180,
  child: Image.asset(
    AppImages.appIcon,
    fit: BoxFit.contain,
  ),
),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Enter your emails and password',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Color(0xff7C7C7C),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Color(0xff7C7C7C),
                      ),
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter an email";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Color(0xff7C7C7C),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordcontroller,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.visibility_off),
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a password";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),

                    SizedBox(height: 20),
                    Obx(
                      () => PrimaryButton(
                        text: "Log In",
                        isLoading: authController.isLoading.value,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            authController.login(
                              email: emailcontroller.text.trim(),
                              password: passwordcontroller.text.trim(),
                            );
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 10),
                  //  comment only for admin


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
