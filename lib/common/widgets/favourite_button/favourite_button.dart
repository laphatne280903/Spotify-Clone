import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/common/bloc/favourite_cubit.dart';
import 'package:my_music_app/common/bloc/favourite_state.dart';
import 'package:my_music_app/domain/entities/song/song.dart';

import '../../../core/configs/theme/app_colors.dart';

class FavouriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function ? function;
  const FavouriteButton({super.key, required this.songEntity, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => FavouriteButtonCubit(),
    child: BlocBuilder<FavouriteButtonCubit,FavouriteButtonState>(
      builder: (context, state){
        if(state is FavouriteButtonInitial){
          return IconButton(
              onPressed: () async{
                await context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                  songEntity.songId
                );
                if(function != null) {
                  function!();
                }
              },
              icon: Icon(
                songEntity.isFavourite? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                color: AppColors.darkgrey,)
          );
        }
        if(state is FavouriteButtonUpdated){
          return IconButton(
              onPressed: (){
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                    songEntity.songId
                );
              },
              icon: Icon(
                state.isFavourite? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                color: AppColors.darkgrey,)
          );
        }
        return Container();
      },
    ),);
  }
}
