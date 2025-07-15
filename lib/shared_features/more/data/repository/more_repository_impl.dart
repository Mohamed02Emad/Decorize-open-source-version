import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/shared_features/auth/data/dataSource/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/static_page_response.dart';
import '../../domain/params/static_pages_params.dart';
import '../../domain/repositories/more_repository.dart';
import '../datasource/more_datasource.dart';

@Injectable(as: MoreRepository)
class MoreRepositoryImpl extends MoreRepository {
  final MoreDatasource dataSource;
  final AuthLocalDataSource localDataSource;

  MoreRepositoryImpl({required this.dataSource, required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> logout() async {
    return dataSource
        .logout()
        .mapError((json) => unit, onSuccess: (data)  async{
          return await _clearCache();
        });
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    return dataSource
        .deleteAccount()
        .mapError((json) => unit, onSuccess: (data)  async{
      return await _clearCache();
    });
  }

  @override
  Future<Either<Failure, StaticPageResponse>> getStaticPages(
      {required StaticPagesParams params}) async {
    return dataSource.getStaticPages(params: params).mapError(
          (json) => StaticPageResponse.fromJson(json),
        );
  }

  Future<void> _clearCache() async {
    localDataSource.clearCache();
  }
}
