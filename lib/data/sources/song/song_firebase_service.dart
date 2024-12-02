import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_music_app/domain/entities/song/song.dart';
import 'package:my_music_app/domain/usecases/song/is_favourite_song.dart';

import '../../../presentation/service_locator.dart';
import '../../models/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemovefromFavourite(String uId);
  Future<bool> isFavouriteSong (String songId);
  Future<Either> getUserFavouriteSongs();

}

class SongFirebaseServiceImp extends SongFirebaseService{
  @override
  Future<Either> getNewsSongs() async{
    try{
      List<SongEntity> songs = [];
      var data= await FirebaseFirestore.instance.collection("Songs")
          .orderBy("releaseDate", descending: true)
          .limit(3)
          .get();

      for(var element in data.docs){
        var songModel = SongModel.fromJson(element.data());
        bool isFavourite = await sl<IsFavouriteSongsUseCase>().call(
          params: element.reference.id
        );
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } on FirebaseException catch(e){
      return const Left("An Error occurred");
    }

  }

  @override
  Future<Either> getPlayList() async {
    try{
      List<SongEntity> listsongs = [];
      //Can change to respective list songs(Now is just simply show up all the songs)
      var data = await FirebaseFirestore.instance.collection("Songs")
      .orderBy("releaseDate", descending: true)
      .get();

      for (var element in data.docs){
        var songModel = SongModel.fromJson(element.data());
        bool isFavourite = await sl<IsFavouriteSongsUseCase>().call(
            params: element.reference.id
        );
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;
        listsongs.add(songModel.toEntity());
      }
      return Right(listsongs);
    } on FirebaseException catch(e){
      return const Left("An Errors occurded");
    }
  }

  @override
  Future<Either> addOrRemovefromFavourite(String songId) async {
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavourite;
      var user = await firebaseAuth.currentUser;
      String uId= user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore.collection("Users")
      .doc(uId)
      .collection("Favourites")
      .where(
        "songId", isEqualTo: songId
      ).get();

      if (favouriteSongs.docs.isNotEmpty) {
       await favouriteSongs.docs.first.reference.delete();
       isFavourite = false;
      } else {
        firebaseFirestore.collection("Users")
            .doc(uId)
            .collection("Favourites")
            .add(
            {
              "songId": songId,
              "addedDate": Timestamp.now()
        });
        isFavourite = true;
      }
      return Right(isFavourite);
    }catch(e){
      return Left("An error occurred!");
    }
  }

  @override
  Future<bool> isFavouriteSong(String songId) async{
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseAuth.currentUser;
      String uId= user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore.collection("Users")
          .doc(uId)
          .collection("Favourites")
          .where(
          "songId", isEqualTo: songId
      ).get();

      if (favouriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      return false;
    }
  }

  @override
  Future<Either> getUserFavouriteSongs() async {
    try{
      final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favouriteSongs = [];

      String uId=user!.uid;
      QuerySnapshot favouritesSnapshot = await firebaseFirestore.collection("Users").doc(uId)
          .collection("Favourites").get();

      for(var element in favouritesSnapshot.docs){
        String songId = element["songId"];
        var song = await firebaseFirestore.collection("Songs").doc(songId).get();
        SongModel songModel= SongModel.fromJson(song.data()!);
        songModel.isFavourite = true;
        songModel.songId = songId;
        favouriteSongs.add(songModel.toEntity());
      }
      return Right(favouriteSongs);
    }catch(e){
      return Left("Errors Occured!");
    }

  }

}