import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_color_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeSegmentColorUsecase extends UseCase<String, ChangeSegmentColorParams>{
  final CreateDesignRepository repository;

  ChangeSegmentColorUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(ChangeSegmentColorParams params) async {
    return repository.changeColor(params);
  }
}
