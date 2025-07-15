import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/domain/params/register_params.dart';
import 'package:injectable/injectable.dart';

import '../models/responses/auth_response.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class RegisterUseCase extends UseCase<AuthResponse, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(RegisterParams params) async {
    return repository.register(params);
  }
}
