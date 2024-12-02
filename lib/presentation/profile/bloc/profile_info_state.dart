import 'package:my_music_app/domain/entities/auth/user.dart';

abstract class ProfileState {
}
class ProfileInfoLoading extends ProfileState{}
class ProfileInfoLoaded extends ProfileState {
  final UserEntity userEntity;

  ProfileInfoLoaded({ required this.userEntity});
}
class ProfileFailure extends ProfileState{}