import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:injectable/injectable.dart';

import '../../domain/params/contact_us_params.dart';
import '../../domain/repositories/contact_us_repository.dart';
import '../datasource/contact_us_datasource.dart';

@Injectable(as: ContactUsRepository)
class ContactUsRepositoryImpl extends ContactUsRepository {
  final ContactUsDatasource dataSource;

  ContactUsRepositoryImpl({
    required this.dataSource,
  });

  //todo : ask back end to add
  @override
  Future<Either<Failure, Unit>> getContactUsData() async {
    return dataSource.getContactUsData().mapError((json) => unit,);
  }

  @override
  Future<Either<Failure, Unit>> sendContactUsMessage(
      {required ContactUsParams params}) async {
         return dataSource.sendContactUsMessage(params: params).mapError((json) => unit,);
  }
}
