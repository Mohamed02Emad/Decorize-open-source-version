import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/user/create_design/data/create_design_urls.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_color_params.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_texture_params.dart';
import 'package:decorizer/user/create_design/domain/params/exit_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/open_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/save_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/segments_params.dart';
import 'package:decorizer/user/create_design/domain/params/suggest_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/upload_ai_image_params.dart';
import 'package:decorizer/user/create_design/domain/params/get_textures_params.dart';
import 'package:injectable/injectable.dart';

abstract class CreateDesignDatasource {
  DatasourceResult uploadImage(UploadAiImageParams params);
  DatasourceResult segments(SegmentsParams params);
  DatasourceResult changeColor(ChangeSegmentColorParams params);
  DatasourceResult changeTexture(ChangeSegmentTextureParams params);
  DatasourceResult saveProject(SaveDesignParams params);
  DatasourceResult exitProject(ExitDesignParams params);
  DatasourceResult openProject(OpenDesignParams params);
  DatasourceResult suggestDesign(SuggestDesignParams params);
  DatasourceResult getTextures(GetTexturesParams params);
}

@Injectable(as: CreateDesignDatasource)
class CreateDesignDatasourceImpl extends CreateDesignDatasource {
  final ApiBaseHelper _apiModelBaseHelper = ApiBaseHelper()
    ..setBaseUrl(CreateDesignUrls.aiBaseUrl);
  final ApiBaseHelper _apiBaseHelper;

  CreateDesignDatasourceImpl(this._apiBaseHelper);

  @override
  DatasourceResult uploadImage(UploadAiImageParams params) async {
    final form = await params.toFormData();
    return _apiModelBaseHelper.post(
        url: CreateDesignUrls.uploadImage(params.projectId), form: form);
  }

  @override
  DatasourceResult segments(SegmentsParams params) {
    return _apiModelBaseHelper.postWithRaw(
        url: CreateDesignUrls.segments(params.projectId),
        body: params.toJson());
  }

  @override
  DatasourceResult changeColor(ChangeSegmentColorParams params) {
    return _apiModelBaseHelper.postWithRaw(
        url: CreateDesignUrls.changeColor(params.projectId),
        body: params.toJson());
  }

  @override
  DatasourceResult changeTexture(ChangeSegmentTextureParams params) async {
    final body = await params.toFormData();
    return _apiModelBaseHelper.post(
        url: CreateDesignUrls.changeTexture(params.projectId), form: body);
  }

  @override
  DatasourceResult saveProject(SaveDesignParams params) async {
    return _apiBaseHelper.post(
      url: CreateDesignUrls.saveProject,
      form: await params.toFormData(),
    );
  }

  @override
  DatasourceResult exitProject(ExitDesignParams params) {
    return _apiModelBaseHelper.post(
      baseUrl: CreateDesignUrls.aiBaseUrl,
      url: CreateDesignUrls.exitProject(params.projectId),
    );
  }

  @override
  DatasourceResult openProject(OpenDesignParams params) {
    return _apiModelBaseHelper.post(
      baseUrl: CreateDesignUrls.aiBaseUrl,
      url: CreateDesignUrls.openProject(params.projectId),
    );
  }

  @override
  DatasourceResult suggestDesign(SuggestDesignParams params) async {
    final customApiHelper = ApiBaseHelper();
    final modelUrlResponse =
        await _apiBaseHelper.get(url: CreateDesignUrls.getModelUrl);
    final customBaseUrl = modelUrlResponse.data['url'].toString();
    customApiHelper.setBaseUrl(customBaseUrl);
    final form = await params.toFormData();
    return customApiHelper.post(
      url: params.isRecreate
          ? CreateDesignUrls.reSuggestDesign(params.projectId)
          : CreateDesignUrls.suggestDesign(params.projectId),
      form: form,
    );
  }

  @override
  DatasourceResult getTextures(GetTexturesParams params) {
    return _apiBaseHelper.get(url: CreateDesignUrls.textures);
  }
}
