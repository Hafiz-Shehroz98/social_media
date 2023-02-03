import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/utils.dart';

import '../../res/component/input_text_field.dart';
import '../../res/component/round_button.dart';
import '../../utils/routes/route_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final userNameController = TextEditingController();
  final userNameFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    userNameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Welcome To Socially",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter Your Email Address\nTo Register To Your Account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * .06, bottom: height * 0.01),
                    child: Column(
                      children: [
                        InputTextField(
                          myController: userNameController,
                          focusNode: userNameFocusNode,
                          onFieldSubmit: (value) {
                            Utils.filedFocus(
                                context, userNameFocusNode, emailFocusNode);
                          },
                          onValidator: (value) {
                            return value.isEmpty ? "Enter Email" : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hint: 'UserName',
                          obSecureText: false,
                          enable: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        InputTextField(
                          myController: emailController,
                          focusNode: emailFocusNode,
                          onFieldSubmit: (value) {
                            Utils.filedFocus(
                                context, emailFocusNode, passwordFocusNode);
                          },
                          onValidator: (value) {
                            return value.isEmpty ? "Enter Email" : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hint: 'Email',
                          obSecureText: false,
                          enable: true,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        InputTextField(
                          myController: passwordController,
                          focusNode: passwordFocusNode,
                          onFieldSubmit: (value) {},
                          onValidator: (value) {
                            return value.isEmpty ? "Enter Password" : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hint: 'Password',
                          obSecureText: true,
                          enable: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                RoundButton(
                  title: "Sign Up",
                  loading: false,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                SizedBox(
                  height: height * .03,
                ),
                Text.rich(
                  TextSpan(
                      text: "Already Have an Account ?",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RouteName.loginScreen);
                            },
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
