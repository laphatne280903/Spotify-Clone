import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_music_app/data/models/auth/signin_user_req.dart';
import 'package:my_music_app/domain/usecases/auth/signin.dart';
import 'package:my_music_app/presentation/authentication/pages/signUp.dart';

import '../../../common/widgets/app_bar/app_bar.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../home/pages/home.dart';
import '../../service_locator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureText = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
            width: 40,
            height: 40,
            AppVectors.logo),
      ),
      bottomNavigationBar: _registerNow(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _signInText(),
              _supportText(),
              const SizedBox(height: 50,),
              _signInTextField(context, "Enter UserName or Email"),
              const SizedBox(height: 20,),
              _passwordTextField(context),
              const SizedBox(height: 33,),
              BasicAppButton(title_button: "Sign In", onPressed: () async {
                var result = await sl<SigninUseCase>().call(
                  params: SignInUserReq(email: _email.text.toString(), password: _passWord.text.toString())
                );
                result.fold(
                        (l) {
                      var snackbar = SnackBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        content: Text(l,
                          style: const TextStyle(color: Colors.red), textAlign: TextAlign.center,), behavior: SnackBarBehavior.floating,);
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                        (r) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()),(route) => false);
                    });;
              }),
          
          
            ],
          ),
        ),
      ),
    );
  }
  Widget _signInText() {
    return const Text("Sign In",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30
      ), textAlign: TextAlign.center,);
  }
  Widget _supportText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("If You Need Any Support",
          style: TextStyle(
              fontSize: 12),),
        TextButton(onPressed: (){}, child: const Text("Click Here",
          style: TextStyle(
              fontSize: 12,
              color: Color(0xFF38B432)),)),
      ],
    );
  }

  //Note this changing theme of the text field
  Widget _signInTextField(BuildContext context, String title) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
          hintText: title
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordTextField(BuildContext context,) {
    return TextField(
      obscureText: _obscureText,
      controller: _passWord,
      decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: (){
            setState(() {
              _obscureText = !_obscureText;
            });
          }, icon: Icon(
              _obscureText? Icons.visibility_off_outlined : Icons.visibility_outlined
          )),
          hintText: "Password"
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _registerNow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Not A Member?"),
          TextButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));},
              child: const Text("Register Now", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF288CE9)
              ),))
        ],
      ),
    );
  }
}
