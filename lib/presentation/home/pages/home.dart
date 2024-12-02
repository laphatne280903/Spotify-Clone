import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_music_app/common/helpers/is_dark_mode.dart';
import 'package:my_music_app/core/configs/assets/app_images.dart';
import 'package:my_music_app/core/configs/theme/app_colors.dart';
import 'package:my_music_app/presentation/home/widgets/news_songs.dart';
import 'package:my_music_app/presentation/home/widgets/play_list.dart';
import 'package:my_music_app/presentation/profile/pages/profile.dart';

import '../../../common/widgets/app_bar/app_bar.dart';
import '../../../core/configs/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        action: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
          icon: const Icon(Icons.person_2_rounded),
        ),
        hidebackbutton: true,
        title: SvgPicture.asset(
            width: 40,
            height: 50,
            AppVectors.logo),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerhomepage(),
            _homeTabBar(),
            SizedBox(
              height: 260,
              child: TabBarView(
                //Each tabs corresponds to its tabs view
                controller: _tabController,
                  children: const [
                    NewsSongs(),
                    NewsSongs(),
                    NewsSongs(),
                    NewsSongs(),

                  ],
              ),
            ),
            PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _headerhomepage () {
    return Center(
      child: SizedBox(
        height: 150,
        child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(AppVectors.homeartist)),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Image.asset(
                    height: 200,
                    AppImages.imagePng("home_artist"),),
                ),
              )
            ])
      ),
    );
}

  Widget _homeTabBar() {
    return TabBar(
      controller: _tabController,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(
          vertical: 30,
        ),
        indicatorColor: AppColors.primary,
        tabs: const [
          Text("News", style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),),
          Text("Video", style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),),
          Text("Artists", style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),),
          Text("Popcasts", style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),),
        ]);
  }
}
