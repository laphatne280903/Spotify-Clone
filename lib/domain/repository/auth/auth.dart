import 'package:dartz/dartz.dart';
import 'package:my_music_app/data/models/auth/create_user_req.dart';
import 'package:my_music_app/data/models/auth/signin_user_req.dart';

abstract class AuthRepository {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SignInUserReq signInUserReq);
  Future<Either> getUser();
}