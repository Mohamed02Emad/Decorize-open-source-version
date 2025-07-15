import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/user/home/data/home_urls.dart';
import 'package:decorizer/user/home/domain/params/suggested_designs_params.dart';
import 'package:injectable/injectable.dart';

abstract class HomeDatasource {
  DatasourceResult getSuggestedDesigns(SuggestedDesignsParams params);
  DatasourceResult getSavedDesigns();
}

@Injectable(as: HomeDatasource)
class HomeDatasourceImpl extends HomeDatasource {
  final ApiBaseHelper _apiBaseHelper;

  HomeDatasourceImpl(this._apiBaseHelper);

  @override
  DatasourceResult getSuggestedDesigns(SuggestedDesignsParams params) {
    return _apiBaseHelper.get(
      url: HomeUrls.suggestedDesigns(params.categoryId),
    );
  }

  @override
  DatasourceResult getSavedDesigns() {
    return _apiBaseHelper.get(url: HomeUrls.savedDesigns);
  }
}
