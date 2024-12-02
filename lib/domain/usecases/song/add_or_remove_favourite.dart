import 'package:dartz/dartz.dart';

import '../../../core/usecases/usecase.dart';
import '../../../presentation/service_locator.dart';
import '../../repository/song/song.dart';

class AddOrRemoveFavouriteUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongRepository>().addOrRemovefromFavourite(params!);
  }
  
}