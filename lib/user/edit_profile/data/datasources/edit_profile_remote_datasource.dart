import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/user/edit_profile/data/edit_profile_urls.dart';
import 'package:decorizer/user/edit_profile/domain/params/change_password_params.dart';
import 'package:decorizer/user/edit_profile/domain/params/get_profile_params.dart';
import 'package:decorizer/user/edit_profile/domain/params/update_profile_params.dart';
import 'package:injectable/injectable.dart';

abstract class EditProfileRemoteDatasource {
  DatasourceResult updateProfile(UpdateProfileParams params);
  DatasourceResult getProfile(GetProfileParams params);
  DatasourceResult changePassword(ChangePasswordParams params);
}

@Injectable(as: EditProfileRemoteDatasource)
class EditProfileRemoteDatasourceImpl implements EditProfileRemoteDatasource {
  final ApiBaseHelper apiHelper;
  EditProfileRemoteDatasourceImpl({required this.apiHelper});

  @override
  DatasourceResult updateProfile(UpdateProfileParams params) async {
    final formData = await params.toFormData();
    return apiHelper.post(
      url: EditProfileUrls.updateProfile,
      form: formData,
    );
  }

  @override
  DatasourceResult getProfile(GetProfileParams params) {
    return apiHelper.get(url: EditProfileUrls.getProfile(params.userId));
  }

  @override
  DatasourceResult changePassword(ChangePasswordParams params) {
    return apiHelper.post(
      url: EditProfileUrls.changePassword,
      body: params.toJson(),
    );
  }
}
