import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/user/create_ad/data/create_ad_urls.dart';
import 'package:decorizer/user/create_ad/domain/params/create_ad_params.dart';
import 'package:decorizer/user/create_ad/domain/params/update_ad_params.dart';
import 'package:injectable/injectable.dart';

abstract class CreateAdRemoteDatasource {
  DatasourceResult createAd(CreateAdParams params);
  DatasourceResult updateAd(UpdateAdParams params);
}

@Injectable(as: CreateAdRemoteDatasource)
class CreateAdRemoteDatasourceImpl extends CreateAdRemoteDatasource {
  final ApiBaseHelper apiHelper;
  CreateAdRemoteDatasourceImpl(this.apiHelper);

  @override
  DatasourceResult createAd(CreateAdParams params) async {
    final body = await params.toJson();
    return apiHelper.post(url: CreateAdUrls.createAd, body: body);
  }

  @override
  DatasourceResult updateAd(UpdateAdParams params) async {
    final body = await params.toJson();
    return apiHelper.post(url: CreateAdUrls.updateAd(params.id), body: body);
  }
}
