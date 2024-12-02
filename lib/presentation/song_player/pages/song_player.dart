import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/common/widgets/favourite_button/favourite_button.dart';
import 'package:my_music_app/core/configs/theme/app_colors.dart';
import 'package:my_music_app/domain/entities/song/song.dart';
import 'package:my_music_app/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:my_music_app/presentation/song_player/bloc/song_player_state.dart';

import '../../../common/widgets/app_bar/app_bar.dart';
import '../../../core/configs/contants/app_urls.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    super.key,
    required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        action: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_vert_rounded),
        ),
        title: const Text("Now playing",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),)
      ),

      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
            "${AppURLs.songsfirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppURLs.mediaAlt}"
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20
          ),
          child: Column(
            children: [
              _songCover(context),
              _songDetail(),
              const SizedBox(height: 10,),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover (BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height *0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
            image: NetworkImage(
                AppURLs.coversfirestorage + songEntity.artist + " - " + songEntity.title + ".jpg?" + AppURLs.mediaAlt
            )
        )
      ),
    );
  }

  Widget _songDetail(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(songEntity.title,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            Text(songEntity.artist,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14
              ),)
          ],
        ),
        //Clicking will add this song to a collection "Favourite" on firestorage
        FavouriteButton(songEntity: songEntity)
      ],
    );
  }
  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state){
          if(state is SongPlayerLoading){
            return const Align(
              alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          if(state is SongPlayerLoaded){
            return Column(
              children: [
                Slider(
                  activeColor: AppColors.primary,
                    value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                    onChanged: (value){}),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songPosition
                      ),
                    ),
                    Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songDuration
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    context.read<SongPlayerCubit>().playOrPauseSong();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Icon(
                      size: 35,
                        context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause_rounded : Icons.play_arrow_rounded
                    ),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary
                    ),
                  ),
                )

              ],
            );
          }
          return Container();
        });
  }

  String formatDuration (Duration duration) {
    final minute = duration.inMinutes.remainder(60);
    final second = duration.inSeconds.remainder(60);
    return "${minute.toString().padLeft(2,"0")}:${second.toString().padLeft(2,"0")}";
  }
}
