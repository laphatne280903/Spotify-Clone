import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_music_app/core/configs/contants/app_urls.dart';
import 'package:my_music_app/data/models/auth/create_user_req.dart';
import 'package:my_music_app/data/models/auth/signin_user_req.dart';
import 'package:my_music_app/data/models/auth/user.dart';
import 'package:my_music_app/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SignInUserReq signInUser);

  Future<Either> getUser();
}
class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SignInUserReq signInUserReq) async{
    try{
      var data = await FirebaseAuth.instance.signInWithEmailAndPassword(email: signInUserReq.email, password: signInUserReq.password);
      return const Right("Sign In Successfully");
    } on FirebaseAuthException catch(e){
      String message = '';

      if (e.code == "wrong-password"){
        message = "UserName or Password is Incorrect";
      } else if (e.code == "invalid-email") {
        message = "Invalid UserName";
      } else if (e.code == "user-not-found"){
        message = "The email provided doesn't exist";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async{
    try {

      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
          .set(
          {
            'name': createUserReq.fullName,
            'email': data.user?.email,
          }
      );
      return const Right("Sign up was successful!");
    } on FirebaseAuthException catch(e){
      String message = '';
      if (e.code == "weak-password") {
        message = "The password provided is too weak";
      } else if (e.code == "email-already-in-use"){
        message = "An account already exists with that email";
      } else if (e.code == "invalid-email"){
        message = "The Email provided is not valid";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async{
    try{
      FirebaseAuth firebaseAuth= FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection("Users").doc(firebaseAuth.currentUser?.uid).get();

      UserModel userModel = UserModel.fromJson(user.data()!); //data() contain all data from "user" document snapshot(await user until getting data)
      userModel.imageURL = firebaseAuth.currentUser?.photoURL?? AppURLs.defaultProfileAvatar;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    }catch(e){
      return Left("An error occurred");
    }


  }

}