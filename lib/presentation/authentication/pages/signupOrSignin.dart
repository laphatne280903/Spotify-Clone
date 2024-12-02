import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_music_app/common/helpers/is_dark_mode.dart';
import 'package:my_music_app/common/widgets/app_bar/app_bar.dart';
import 'package:my_music_app/common/widgets/button/basic_app_button.dart';
import 'package:my_music_app/core/configs/assets/app_images.dart';
import 'package:my_music_app/core/configs/assets/app_vectors.dart';
import 'package:my_music_app/presentation/authentication/pages/signIn.dart';
import 'package:my_music_app/presentation/authentication/pages/signUp.dart';


class SignupOrSigninScreen extends StatefulWidget {
  const SignupOrSigninScreen({super.key});

  @override
  State<SignupOrSigninScreen> createState() => _SignupOrSigninScreenState();
}

class _SignupOrSigninScreenState extends State<SignupOrSigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  AppVectors.topleftpattern,
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  AppVectors.bottompattern,
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Image(image: AssetImage(AppImages.imagePng("authentication_bg")))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Column(
              children: [
                SvgPicture.asset(AppVectors.logo),
                const SizedBox(height: 55,),
                const Text("Enjoy Listening To Music",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26
                ),),
                const SizedBox(height: 21,),
                const Text("Spotify is a proprietary Swedish audio streaming and media services provider",
                  style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child: BasicAppButton(title_button: "Register", onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        }, height: 73,)),
                    // const Spacer(),
                    // BasicAppButton(title_button: "Sign in", onPressed: (){},  height: 73, width: 147,)
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 73,
                        child: TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                            },
                            child: Text("Sign In", style: TextStyle(
                              fontSize: 20,
                              color: context.isDarkMode ? Colors.white : Colors.black
                            ),)),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
