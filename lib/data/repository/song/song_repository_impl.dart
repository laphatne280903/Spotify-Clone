import 'package:dartz/dartz.dart';
import 'package:my_music_app/data/sources/song/song_firebase_service.dart';
import 'package:my_music_app/domain/repository/song/song.dart';

import '../../../presentation/service_locator.dart';

class SongRepositoryImpl extends SongRepository{
  @override
  Future<Either> getNewsSongs() async{
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemovefromFavourite(String songId) async {
   return await sl<SongFirebaseService>().addOrRemovefromFavourite(songId);
  }

  @override
  Future<bool> isFavouriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavouriteSong(songId);

  }

  @override
  Future<Either> getUserFavouriteSong() async{
    return await sl<SongFirebaseService>().getUserFavouriteSongs();
  }
}