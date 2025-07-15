import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../models/user.dart';
import '../../repositories/local_repository.dart';

@Injectable()
class GetCachedUserUseCase extends UseCase<User?  , NoParams>{
  final LocalRepository repository;

  GetCachedUserUseCase(this.repository);


  @override
  Future<Either<Failure, User?>> call(NoParams params) async{
    final token = repository.getCachedUser();
    return Right(token);
  }

}