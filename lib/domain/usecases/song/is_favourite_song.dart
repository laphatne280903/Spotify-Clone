import 'package:dartz/dartz.dart';

import '../../../core/usecases/usecase.dart';
import '../../../presentation/service_locator.dart';
import '../../repository/song/song.dart';

class IsFavouriteSongsUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String ?params}) async{
    return await sl<SongRepository>().isFavouriteSong(params!);
  }

}