import 'package:get_it/get_it.dart';
import 'package:my_music_app/data/repository/auth/auth_repository_impl.dart';
import 'package:my_music_app/data/repository/song/song_repository_impl.dart';
import 'package:my_music_app/data/sources/auth/auth_firebase_service.dart';
import 'package:my_music_app/data/sources/song/song_firebase_service.dart';
import 'package:my_music_app/domain/repository/auth/auth.dart';
import 'package:my_music_app/domain/repository/song/song.dart';
import 'package:my_music_app/domain/usecases/auth/getUser.dart';
import 'package:my_music_app/domain/usecases/auth/signup.dart';
import 'package:my_music_app/domain/usecases/song/add_or_remove_favourite.dart';
import 'package:my_music_app/domain/usecases/song/getUserFavouriteSong.dart';
import 'package:my_music_app/domain/usecases/song/get_news_songs.dart';
import 'package:my_music_app/domain/usecases/song/get_play_list.dart';
import 'package:my_music_app/domain/usecases/song/is_favourite_song.dart';

import '../domain/usecases/auth/signin.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Authentication
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );
  sl.registerSingleton<SigninUseCase>(
      SigninUseCase()
  );

  //Get new song
  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImp()
  );
  sl.registerSingleton<SongRepository>(
      SongRepositoryImpl()
  );
  sl.registerSingleton<GetNewsSongsUseCase>(
      GetNewsSongsUseCase()
  );

  //Get play list
  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase()
  );

  //Add or Remove Favourite Songs
  sl.registerSingleton<AddOrRemoveFavouriteUseCase>(
    AddOrRemoveFavouriteUseCase()
  );

  sl.registerSingleton<IsFavouriteSongsUseCase>(
    IsFavouriteSongsUseCase()
  );

  //Get User data to present in Profile page
  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase()
  );

  //Get UserfavSongs present in Profile page
  sl.registerSingleton<GetUserFavouriteSongUseCase>(
    GetUserFavouriteSongUseCase()
  );
}