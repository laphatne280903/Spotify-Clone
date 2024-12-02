import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/domain/entities/song/song.dart';
import 'package:my_music_app/domain/usecases/song/getUserFavouriteSong.dart';
import 'package:my_music_app/presentation/profile/bloc/get_user_favourite_song_state.dart';

import '../../service_locator.dart';

class GetUserFavouriteSongsCubit extends Cubit<GetUserFavouriteState> {
  GetUserFavouriteSongsCubit() : super(GetUserFavouriteLoading());

  List<SongEntity> favouriteSongs = [];
  Future<void> getUserFavouriteSongs() async{
    var result = await sl<GetUserFavouriteSongUseCase>().call();

    result.fold(
            (l) {
              emit(GetUserFavouriteFailure()
              );
            },

            (r) {
              favouriteSongs = r;
              emit(
                  GetUserFavouriteLoaded(favouriteSongs: favouriteSongs));
            });
  }
  void RemovedSong(int index) {
    favouriteSongs.removeAt(index);
    emit(GetUserFavouriteLoaded(favouriteSongs: favouriteSongs));
  }
}