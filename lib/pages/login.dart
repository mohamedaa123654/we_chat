import 'package:flutter/material.dart';
import 'package:we_chat/componants/constant.dart';
import 'package:we_chat/componants/custom_button.dart';
import 'package:we_chat/componants/custom_text_button.dart';
import 'package:we_chat/componants/custom_text_feild.dart';
import 'package:we_chat/componants/size_config.dart';
import 'package:we_chat/pages/register.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  String id = 'Login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            SizedBox(
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
            SizedBox(
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
            const CustomTextFeild(
              label: 'Email',
              prefix: Icons.email_outlined,
              hint: 'Enter Your Email',
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomTextFeild(
              label: 'Password',
              prefix: Icons.lock_outline,
              hint: 'Enter Your Password',
              isPassword: true,
            ),
            const SizedBox(
              height: 10,
            ),
            const Custom_Button(text: 'Login'),
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
                    Navigator.pushNamed(context, Register().id);
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
    );
  }
}
