import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/user/home/data/home_urls.dart';
import 'package:decorizer/user/home/domain/params/all_designs_params.dart';
import 'package:decorizer/user/home/domain/params/suggested_designs_params.dart';
import 'package:injectable/injectable.dart';

abstract class HomeRemoteDataSource {
  DatasourceResult getSuggestedDesigns(SuggestedDesignsParams params);
  DatasourceResult getSavedDesigns();
  DatasourceResult getAllDesigns(AllDesignsParams params);
}

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiBaseHelper apiHelper;

  HomeRemoteDataSourceImpl(this.apiHelper);

  @override
  DatasourceResult getSuggestedDesigns(SuggestedDesignsParams params) {
    return apiHelper.get(url: HomeUrls.suggestedDesigns(params.categoryId));
  }

  @override
  DatasourceResult getSavedDesigns() {
    return apiHelper.get(url: HomeUrls.savedDesigns);
  }

  @override
  DatasourceResult getAllDesigns(AllDesignsParams params) {
    return apiHelper.get(
        url: HomeUrls.allDesigns(params.page, params.categoryId, params.query));
  }
}
