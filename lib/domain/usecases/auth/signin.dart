import 'package:dartz/dartz.dart';
import 'package:my_music_app/core/usecases/usecase.dart';
import 'package:my_music_app/data/models/auth/create_user_req.dart';
import 'package:my_music_app/data/models/auth/signin_user_req.dart';
import 'package:my_music_app/domain/repository/auth/auth.dart';
import '../../../presentation/service_locator.dart';


class SigninUseCase implements UseCase<Either,SignInUserReq> {
  @override
  Future<Either> call({SignInUserReq ? params}) {
    return sl<AuthRepository>().signin(params!);
  }

}