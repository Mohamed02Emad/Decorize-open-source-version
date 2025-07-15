import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/user/saved_designs/data/saved_designs_urls.dart';
import 'package:decorizer/user/saved_designs/domain/params/get_saved_designs_params.dart';
import 'package:injectable/injectable.dart';

abstract class SavedDesignsDataSource {
  DatasourceResult getSavedDesigns(GetSavedDesignsParams params);
}

@Injectable(as: SavedDesignsDataSource)
class SavedDesignsDataSourceImpl implements SavedDesignsDataSource {
  final ApiBaseHelper apiHelper;

  SavedDesignsDataSourceImpl(this.apiHelper);

  @override
  DatasourceResult getSavedDesigns(GetSavedDesignsParams params) {
    return apiHelper.get(
      url: SavedDesignsUrls.savedDesigns(params.page, params.query),
    );
  }
}
