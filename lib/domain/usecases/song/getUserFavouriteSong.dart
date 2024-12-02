import 'package:dartz/dartz.dart';
import 'package:my_music_app/core/usecases/usecase.dart';
import 'package:my_music_app/domain/repository/song/song.dart';

import '../../../presentation/service_locator.dart';

class GetUserFavouriteSongUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
    return await sl<SongRepository>().getUserFavouriteSong();
  }

}