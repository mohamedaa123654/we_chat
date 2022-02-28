import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:we_chat/componants/constant.dart';
import 'package:we_chat/componants/custom_button.dart';
import 'package:we_chat/componants/custom_text_button.dart';
import 'package:we_chat/componants/custom_text_feild.dart';
import 'package:we_chat/componants/size_config.dart';
import 'package:we_chat/pages/register.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(height: 100, child: Image.asset(kLogo)),
                const Text(
                  'We Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                  // height: SizeConfig.screenHeight! * 0.1,
                ),
                Row(
                  children: const [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                  prefix: Icons.email_outlined,
                  hint: 'Enter Your Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                  prefix: Icons.lock_outline,
                  hint: 'Enter Your Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Button(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      // await loginUser();

                      if (formKey.currentState!.validate()) {
                        try {
                          await loginUser();
                          Navigator.pushNamed(context, chatPageId,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('No user found for that email.'),
                            ));
                            // print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Wrong password provided for that user.'),
                            ));
                            // print('Wrong password provided for that user.');
                          }
                        } catch (ex) {
                          print(ex);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('There was an error'),
                          ));
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Custom_Text_Button(
                      onTap: () {
                        Navigator.pushNamed(context, registerId);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Register()));
                      },
                      text: 'Register',
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  // Future<void> loginUser() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email!, password: password!);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('No user found for that email.'),
  //       ));

  //       // print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Wrong password provided for that user.'),
  //       ));

  //       // print('Wrong password provided for that user.');
  //     }
  //   }
  //   isLoading = false;
  //   setState(() {});
  // }
}
