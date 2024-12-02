import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_music_app/common/widgets/button/basic_app_button.dart';
import 'package:my_music_app/core/configs/assets/app_images.dart';
import 'package:my_music_app/core/configs/assets/app_vectors.dart';
import 'package:my_music_app/core/configs/theme/app_colors.dart';
import 'package:my_music_app/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImages.imagePng("intro"),
                )
              )
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
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
                  "Enjoy Listening To Music",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 21,),

                const Text("Whether you're a seasoned audiophile or just starting your musical journey, our app brings you an extensive library of songs, curated playlists, and personalized recommendations tailored to your unique taste.",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey
                  ),
                  textAlign: TextAlign.center,),
                const SizedBox(height: 37,),
                BasicAppButton(
                  title_button: "Get Stared",
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseModeScreen()));
                  },)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
