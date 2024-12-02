import 'package:dartz/dartz.dart';
import 'package:my_music_app/core/usecases/usecase.dart';
import '../../../presentation/service_locator.dart';
import '../../repository/song/song.dart';

class GetPlayListUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
    return await sl<SongRepository>().getPlayList();
  }
}
