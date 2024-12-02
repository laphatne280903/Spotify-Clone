import '../../../domain/entities/song/song.dart';

abstract class GetUserFavouriteState{}
class GetUserFavouriteLoading extends GetUserFavouriteState{}
class GetUserFavouriteLoaded extends GetUserFavouriteState {
  final List<SongEntity> favouriteSongs;

  GetUserFavouriteLoaded({required this.favouriteSongs});
}
class GetUserFavouriteFailure extends GetUserFavouriteState{}
