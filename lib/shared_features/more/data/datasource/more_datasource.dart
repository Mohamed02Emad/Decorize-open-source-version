import 'package:decorizer/shared_features/more/data/more_end_points.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/data/remote/datasource_result.dart';
import '../../../../common/util/api_basehelper.dart';
import '../../domain/params/static_pages_params.dart';

abstract class MoreDatasource {
  DatasourceResult logout();

  DatasourceResult deleteAccount();

  DatasourceResult getStaticPages({required StaticPagesParams params});
}

@Injectable(as: MoreDatasource)
class MoreDatasourceImpl extends MoreDatasource {
  final ApiBaseHelper helper;

  MoreDatasourceImpl(this.helper);

  @override
  DatasourceResult logout() async {
    return helper.post(
      url: MoreEndPoints.logoutApi,
    );
  }

  @override
  DatasourceResult deleteAccount() async {
    return helper.delete(
      url: MoreEndPoints.deleteAccountApi,
    );
  }

  @override
  DatasourceResult getStaticPages({required StaticPagesParams params}) async {
    return helper.get(
      url: MoreEndPoints.staticPagesApi,
      queryParameters: params.toJson(),
    );
  }
}
