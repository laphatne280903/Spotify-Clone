import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/common/helpers/is_dark_mode.dart';
import 'package:my_music_app/presentation/home/bloc/play_list_cubit.dart';
import 'package:my_music_app/presentation/home/bloc/play_list_state.dart';
import 'package:my_music_app/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favourite_button/favourite_button.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';

class PlayList extends StatelessWidget {
  PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PlayListCubit()..getPlayList(),
        child: BlocBuilder<PlayListCubit, PlayListState>(
          builder: (context, state) {
            if(state is PlayListLoading){
              return  Container(
                alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
            if(state is PlayListLoaded){
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Playlist",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),),
                        TextButton(
                            onPressed: (){},
                            child: const Text("See more",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xffC6C6C6)
                              ),))
                      ],
                    ),
                    const SizedBox(height: 16,),
                    _playlistsong(state.songs),
                  ],
                ),
              );
            }
            return Container();
    },
    ),
    );
  }

  //Seperated into single element songs to handle OnTap
  Widget _playlistsong (List<SongEntity> listsong){
    //Learn more about ListView.separated
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              //passing songs entity to player page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      SongPlayerPage(songEntity: listsong[index],)));
            },
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkMode? AppColors.darkgrey : const Color(0xffE6E6E6)
                  ),
                  child: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.play_arrow_rounded),
                    color: context.isDarkMode? const Color(0xff959595) : const Color(0xff555555),
                  ),
                ),
                const SizedBox(width: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listsong[index].title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      Text(listsong[index].artist,
                        maxLines: 1,
                      style: const  TextStyle(
                        fontSize: 12
                      ),),
                    ],
                  ),
                ),
                const Spacer(),
                Text(listsong[index].duration.toString().replaceAll(".", ":")),
                const Spacer(),
                FavouriteButton(songEntity: listsong[index],),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 15,),
        itemCount: listsong.length);
}
}
