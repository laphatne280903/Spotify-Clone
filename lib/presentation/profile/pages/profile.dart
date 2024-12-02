
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/common/helpers/is_dark_mode.dart';
import 'package:my_music_app/common/widgets/favourite_button/favourite_button.dart';
import 'package:my_music_app/domain/entities/song/song.dart';
import 'package:my_music_app/presentation/profile/bloc/get_user_favourite_song_cubit.dart';
import 'package:my_music_app/presentation/profile/bloc/get_user_favourite_song_state.dart';
import 'package:my_music_app/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:my_music_app/presentation/profile/bloc/profile_info_state.dart';
import 'package:my_music_app/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/app_bar/app_bar.dart';
import '../../../core/configs/contants/app_urls.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: context.isDarkMode? const Color(0xff2C2B2B) : Colors.white,
        action: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_vert_rounded),
        ),
        hidebackbutton: true,
        title: const Text("Profile",
        style: TextStyle(
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileInfo(context),
            const SizedBox(height: 20,),
            _favouriteSongs(),
          ],
        ),
      ),
    );
  }
  Widget _profileInfo(BuildContext context){
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height/3,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)
          ),
          color: context.isDarkMode? Color(0xff2C2B2B) : Colors.white
        ),
        child: BlocBuilder<ProfileCubit, ProfileState> (
          builder: (context,state) {
            if(state is ProfileInfoLoading){
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
            if(state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          state.userEntity.imageURL!
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(state.userEntity.fullName!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 10,),
                  Text(state.userEntity.email!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200
                    ),)
                ],
              );
            }
            if(state is ProfileFailure){
              return const Text("Errors occurred, check again!");
            }
            return Container();
          },
        ),
      ),
    );
  }
  Widget _favouriteSongs() {
    return BlocProvider(
        create: (context) => GetUserFavouriteSongsCubit()..getUserFavouriteSongs(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("FAVOURITE SONG"),
              const SizedBox(height: 20,),

              BlocBuilder<GetUserFavouriteSongsCubit, GetUserFavouriteState>(
                  builder: (context, state) {
                    if(state is GetUserFavouriteLoading){
                      return const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(state is GetUserFavouriteLoaded){
                      return ListView.separated(
                        shrinkWrap: true,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayerPage(songEntity: state.favouriteSongs[index])));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppURLs.coversfirestorage + state.favouriteSongs[index].artist + " - " + state.favouriteSongs[index].title + ".jpg?" + AppURLs.mediaAlt
                                        )
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    height: 56,
                                    width: 58,
                                  ),
                                  const SizedBox(width: 10,),
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.favouriteSongs[index].title,
                                          maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),),
                                        Text(state.favouriteSongs[index].artist,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11
                                          ),),
                                      ],
                                    ),
                                    width: MediaQuery.of(context).size.width *0.45,
                                  ),
                                  const Spacer(),
                                  Text(state.favouriteSongs[index].duration.toString().replaceAll(".", ":")),
                                  const SizedBox(width: 10,),
                                  FavouriteButton(
                                    key: UniqueKey(),
                                      songEntity: state.favouriteSongs[index],
                                      function: () => context.read<GetUserFavouriteSongsCubit>().RemovedSong(index),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 20,),
                          itemCount: state.favouriteSongs.length);
                    }
                    if(state is GetUserFavouriteFailure) {
                      return const Text("Please try again");
                    }
                    return Container();
                  })
            ],
          ),
        ),);

  }
}
