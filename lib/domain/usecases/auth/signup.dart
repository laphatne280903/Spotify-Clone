import 'package:dartz/dartz.dart';
import 'package:my_music_app/core/usecases/usecase.dart';
import 'package:my_music_app/data/models/auth/create_user_req.dart';
import 'package:my_music_app/domain/repository/auth/auth.dart';
import '../../../presentation/service_locator.dart';


class SignupUseCase implements UseCase<Either,CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq ? params}) {
   return sl<AuthRepository>().signup(params!);
  }

}