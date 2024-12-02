import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_music_app/core/configs/assets/app_vectors.dart';
import 'package:my_music_app/presentation/authentication/pages/signupOrSignin.dart';
import 'package:my_music_app/presentation/choose_mode/bloc/theme_cubit.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(60),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppImages.imagePng("choosemodebg"),
                    )
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 40
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.logo)),
                const Spacer(),
                const Text(
                  "Choose Mode",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 21,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: const Color(0xff30393C).withOpacity(0.5),
                                  shape: BoxShape.circle
                                ),
                                child: SvgPicture.asset(
                                    fit: BoxFit.none,
                                    AppVectors.darkMode),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const Text("Dark Mode", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffDADADA),
                          fontSize: 17,
                        ),),
                      ],
                    ),

                    const SizedBox(width: 40,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: const Color(0xff30393C).withOpacity(0.5),
                                    shape: BoxShape.circle
                                ),
                                child: SvgPicture.asset(
                                    fit: BoxFit.none,
                                    AppVectors.lightMode),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const Text("Light Mode", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffDADADA),
                          fontSize: 17,
                        ),),
                      ],
                    ),

                  ],
                ),
                const SizedBox(height: 37,),
                BasicAppButton(
                  title_button: "Continute",
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupOrSigninScreen()));
                  },)
              ],
            ),
          ),

        ],
      ),
    );

  }
}
