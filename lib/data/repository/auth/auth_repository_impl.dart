import 'package:dartz/dartz.dart';
import 'package:my_music_app/data/models/auth/create_user_req.dart';
import 'package:my_music_app/data/models/auth/signin_user_req.dart';
import 'package:my_music_app/data/sources/auth/auth_firebase_service.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../presentation/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SignInUserReq signInUserReq) async {
    return await sl<AuthFirebaseService>().signin(signInUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();

  }
}