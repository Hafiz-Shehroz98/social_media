import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/component/input_text_field.dart';
import 'package:social_media/res/component/round_button.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/viewModel/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
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
                  "Enter Your Email & Password\nTo Connect To Your Account",
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
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteName.forgotPasswordScreen);
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 15, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                      builder: (context, provider, child) {
                    return RoundButton(
                      title: "Login",
                      loading: provider.loading,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          provider.login(context, emailController.text,
                              passwordController.text);
                        }
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Text.rich(
                  TextSpan(
                      text: "Don't Have an Account ?",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RouteName.signUpScreen);
                            },
                          text: "Sign Up",
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
