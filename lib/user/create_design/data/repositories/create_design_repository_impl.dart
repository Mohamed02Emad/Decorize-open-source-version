import 'package:dartz/dartz.dart';
import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/data/datasources/create_design_datasource.dart';
import 'package:decorizer/user/create_design/domain/models/design_segments_model.dart';
import 'package:decorizer/user/create_design/domain/models/suggest_design_model.dart';
import 'package:decorizer/user/create_design/domain/models/upload_design_model.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_color_params.dart';
import 'package:decorizer/user/create_design/domain/params/segments_params.dart';
import 'package:decorizer/user/create_design/domain/params/suggest_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/upload_ai_image_params.dart';
import 'package:decorizer/user/create_design/domain/repositories/create_design_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_texture_params.dart';
import 'package:decorizer/user/create_design/domain/params/save_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/exit_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/open_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/get_textures_params.dart';
import 'package:decorizer/user/create_design/domain/models/texture_model.dart';

@Injectable(as: CreateDesignRepository)
class CreateDesignRepositoryImpl extends CreateDesignRepository {
  final CreateDesignDatasource _createDesignDatasource;

  CreateDesignRepositoryImpl(this._createDesignDatasource);

  @override
  Future<Either<Failure, UploadDesignModel>> uploadImage(
      UploadAiImageParams params) async {
    return _createDesignDatasource
        .uploadImage(params)
        .mapError(UploadDesignModel.fromJson);
  }

  @override
  Future<Either<Failure, DesignSegmentsModel>> segments(
      SegmentsParams params) async {
    return _createDesignDatasource
        .segments(params)
        .mapError(DesignSegmentsModel.fromJson);
  }

  @override
  Future<Either<Failure, String>> changeColor(
      ChangeSegmentColorParams params) async {
    return _createDesignDatasource.changeColor(params).mapError(
          (json) => json['Image'] as String,
        );
  }

  @override
  Future<Either<Failure, String>> changeTexture(
      ChangeSegmentTextureParams params) async {
    return _createDesignDatasource.changeTexture(params).mapError(
          (json) => json['Image'] as String,
        );
  }

  @override
  Future<Either<Failure, Unit>> saveProject(SaveDesignParams params) async {
    return _createDesignDatasource.saveProject(params).mapError(
          (_) => unit,
        );
  }

  @override
  Future<Either<Failure, Unit>> exitProject(ExitDesignParams params) async {
    return _createDesignDatasource.exitProject(params).mapError(
          (_) => unit,
        );
  }

  @override
  Future<Either<Failure, Unit>> openProject(OpenDesignParams params) async {
    return _createDesignDatasource.openProject(params).mapError(
          (_) => unit,
        );
  }

  @override
  Future<Either<Failure, SuggestDesignModel>> suggestDesign(
      SuggestDesignParams params) async {
    return _createDesignDatasource.suggestDesign(params).mapError(
          SuggestDesignModel.fromJson,
        );
  }

  @override
  Future<Either<Failure, List<TextureModel>>> getTextures(
      GetTexturesParams params) async {
    return _createDesignDatasource.getTextures(params).mapError(
          (json) => texturesFromJson(json['data'] ?? []),
        );
  }
}
