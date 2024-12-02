import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/common/bloc/favourite_state.dart';
import 'package:my_music_app/domain/usecases/song/add_or_remove_favourite.dart';

import '../../presentation/service_locator.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState>{
  FavouriteButtonCubit() : super(FavouriteButtonInitial()) ;

  Future<void> favouriteButtonUpdated(String songId) async {
    var result = await sl<AddOrRemoveFavouriteUseCase>().call(
      params: songId
    );

    result.fold(
            (l) {

            },
            (isFavourite) {
              emit(FavouriteButtonUpdated(isFavourite: isFavourite));
            });
  }
}