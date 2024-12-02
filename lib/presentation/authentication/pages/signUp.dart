
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_music_app/common/widgets/app_bar/app_bar.dart';
import 'package:my_music_app/common/widgets/button/basic_app_button.dart';
import 'package:my_music_app/core/configs/assets/app_vectors.dart';
import 'package:my_music_app/data/models/auth/create_user_req.dart';
import 'package:my_music_app/domain/usecases/auth/signup.dart';
import 'package:my_music_app/presentation/authentication/pages/signIn.dart';

import '../../home/pages/home.dart';
import '../../service_locator.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullName= TextEditingController();
  final TextEditingController _passWord= TextEditingController();
  final TextEditingController _email= TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
            width: 40,
            height: 40,
            AppVectors.logo),
      ),
      bottomNavigationBar: _backToSignIn(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _registerText(),
              _supportText(),
              const SizedBox(height: 50,),
              _registerTextField(context, "Full Name", _fullName),
              const SizedBox(height: 20,),
              _registerTextField(context, "Enter Email", _email),
              const SizedBox(height: 20,),
              _passwordTextField(context),
              const SizedBox(height: 33,),
              BasicAppButton(title_button: "Create Account", onPressed: () async {
                var result= await sl<SignupUseCase>().call(
                  params: CreateUserReq(
                      fullName: _fullName.text.toString(),
                      email: _email.text.toString(),
                      password: _passWord.text.toString())
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
                        });
              }),

            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text("Register",
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
  Widget _registerTextField(BuildContext context, String title, TextEditingController controller) {
    return TextField(
      controller: controller,
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

  Widget _backToSignIn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Do You Have An Account?"),
          TextButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));},
              child: const Text("Sign In", style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF288CE9)
              ),))
        ],
      ),
    );
  }
}
