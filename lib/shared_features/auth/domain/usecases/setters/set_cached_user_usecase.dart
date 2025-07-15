import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../models/user.dart';
import '../../repositories/local_repository.dart';

@Injectable()
class SetCachedUserUseCase extends UseCase<Unit  , User?>{
  final LocalRepository repository;

  SetCachedUserUseCase(this.repository);


  @override
  Future<Either<Failure, Unit>> call(User? params) async{
    repository.setCachedUser(params);
    return const Right(unit);
  }
}