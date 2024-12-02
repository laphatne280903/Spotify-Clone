import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/domain/usecases/song/get_news_songs.dart';
import 'package:my_music_app/presentation/home/bloc/news_song_state.dart';

import '../../service_locator.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();
    returnedSongs.fold(
            (l) {
              emit(NewSongsLoadedFailure());
            },
            (data) {
              emit(NewSongsLoaded(songs: data));
            });
  }
}