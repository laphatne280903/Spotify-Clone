import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/domain/usecases/auth/getUser.dart';
import 'package:my_music_app/presentation/profile/bloc/profile_info_state.dart';

import '../../service_locator.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async{
    var user = await sl<GetUserUseCase>().call();
    user.fold(
            (l){
              emit(ProfileFailure());
            },
            (userEntity) {
              emit(ProfileInfoLoaded(userEntity: userEntity));
            });
  }
}