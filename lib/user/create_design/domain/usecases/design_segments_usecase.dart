import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/usecase.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/models/design_segments_model.dart';
import 'package:decorizer/user/create_design/domain/params/segments_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DesignSegmentsUsecase extends UseCase<DesignSegmentsModel, SegmentsParams>{
  final CreateDesignRepository repository;

  DesignSegmentsUsecase(this.repository);

  @override
  Future<Either<Failure, DesignSegmentsModel>> call(SegmentsParams params) async {
    return repository.segments(params);
  }
}
