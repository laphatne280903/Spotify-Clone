import 'package:dartz/dartz.dart';

import '../../../core/usecases/usecase.dart';
import '../../../presentation/service_locator.dart';
import '../../repository/auth/auth.dart';

class GetUserUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async{
    return await sl<AuthRepository>().getUser();
  }

}