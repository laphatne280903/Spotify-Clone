import '../../../domain/entities/song/song.dart';

abstract class NewSongsState {}

class NewSongsLoading extends NewSongsState {}

class NewSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;

  NewSongsLoaded({required this.songs});
}

class NewSongsLoadedFailure extends NewSongsState{}
