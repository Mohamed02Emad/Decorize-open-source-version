import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/shared_features/static/data/static_urls.dart';
import 'package:decorizer/shared_features/static/domain/params/get_cities_params.dart';
import 'package:injectable/injectable.dart';

abstract class StaticRemoteDataSource{
  DatasourceResult getGovernorates();
    DatasourceResult getCities(GetCitiesParams params);
    DatasourceResult getTypes();
    DatasourceResult getCategories();
}

@Injectable(as: StaticRemoteDataSource)
class StaticRemoteDataSourceImpl extends StaticRemoteDataSource{
  final ApiBaseHelper apiHelper;

  StaticRemoteDataSourceImpl(this.apiHelper);

  @override
  DatasourceResult getGovernorates() async {
    return apiHelper.get(url: StaticUrls.governorates);
  }

  @override
  DatasourceResult getCities(GetCitiesParams params) async {
    return apiHelper.get(url: StaticUrls.cities(params.governorateId));
  }

  @override
  DatasourceResult getTypes() async {
    return apiHelper.get(url: StaticUrls.types);
  }

  @override
  DatasourceResult getCategories() async {
    return apiHelper.get(url: StaticUrls.categories);
  }
}


