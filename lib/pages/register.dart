import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:we_chat/componants/constant.dart';
import 'package:we_chat/componants/custom_button.dart';
import 'package:we_chat/componants/custom_text_button.dart';
import 'package:we_chat/componants/custom_text_feild.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

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
                SizedBox(height: 100, child: Image.asset(kLogo)),
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
                      'Register',
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
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        registerUser(context);
                      }
                    },
                    text: 'Register'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Custom_Text_Button(
                      text: 'Login',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser(BuildContext context) {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      Navigator.pushNamed(context, chatPageId);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
        ));
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
        ));
        // print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    setState(() {});
  }
}
