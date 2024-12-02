import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/domain/usecases/song/get_play_list.dart';
import 'package:my_music_app/presentation/home/bloc/play_list_state.dart';

import '../../service_locator.dart';

class PlayListCubit extends Cubit<PlayListState>{
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold(
            (l) {
              emit(PlayListLoadedFailure());
            },
            (data) {
              //emit to Updates the state to the provided state
              //
              emit (PlayListLoaded(songs: data)) ;
            });
  }
}