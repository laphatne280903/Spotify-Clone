
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/common/helpers/is_dark_mode.dart';
import 'package:my_music_app/core/configs/contants/app_urls.dart';
import 'package:my_music_app/core/configs/theme/app_colors.dart';
import 'package:my_music_app/presentation/home/bloc/news_song_state.dart';
import 'package:my_music_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:my_music_app/presentation/song_player/pages/song_player.dart';

import '../../../domain/entities/song/song.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //Create NewsongsCubit object and call method getNewSongs right after that
        create: (_) => NewSongsCubit()..getNewsSongs(),
        child: SizedBox(
          height: 200,
          child: BlocBuilder<NewSongsCubit, NewSongsState>(
            builder: (context, state) {
              if(state is NewSongsLoading){
                return Container(
                  alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }
              if (state is NewSongsLoaded){
                //passing list of songs type NewSongsState
                return _songs(state.songs);
              }
              return Container();
            },
          )
        ),
    );
  }
  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    SongPlayerPage(songEntity: songs[index],)));
          },
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      //Use DecorationImage to define url link image sources, here geted from firestorage
                        image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          //Should pass from outside
                          AppURLs.coversfirestorage + songs[index].artist + " - " + songs[index].title + ".jpg?" + AppURLs.mediaAlt
                        )
                      )
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 40,
                        height: 40,
                        //Transform to move the position of this object in 3 direction.
                        transform: Matrix4.translationValues(10, 10, 0),
                        child: Icon(Icons.play_arrow_rounded,
                        color: context.isDarkMode? Color(0xff959595) : Color(0xff555555),),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode? AppColors.darkgrey : const Color(0xffE6E6E6),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(songs[index].title,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,

                ),),
                Text(songs[index].artist,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12
                  ),),

              ],
            ),
          ),
        );
      },
      itemCount: songs.length,
      //Learn more about this attribute
      separatorBuilder: (context, index) => const SizedBox(width: 14,),
    );
  }
}
