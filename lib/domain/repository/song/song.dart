import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemovefromFavourite(String songId);
  Future<bool> isFavouriteSong (String songId);
  Future<Either> getUserFavouriteSong();
}