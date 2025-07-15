import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../models/responses/auth_response.dart';
import '../params/login_params.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class LoginUseCase extends UseCase<AuthResponse, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(LoginParams params) async {
    return repository.login(params);
  }
}
