import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:decorizer/common/failure.dart';
import 'package:decorizer/user/create_design/domain/models/design_segments_model.dart';
import 'package:decorizer/user/create_design/domain/models/suggest_design_model.dart';
import 'package:decorizer/user/create_design/domain/models/upload_design_model.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_color_params.dart';
import 'package:decorizer/user/create_design/domain/params/change_segment_texture_params.dart';
import 'package:decorizer/user/create_design/domain/params/exit_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/open_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/save_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/segments_params.dart';
import 'package:decorizer/user/create_design/domain/params/suggest_design_params.dart';
import 'package:decorizer/user/create_design/domain/params/upload_ai_image_params.dart';
import 'package:decorizer/user/create_design/domain/params/get_textures_params.dart';
import 'package:decorizer/user/create_design/domain/models/texture_model.dart';

abstract class CreateDesignRepository {
  Future<Either<Failure, UploadDesignModel>> uploadImage(
      UploadAiImageParams params);
  Future<Either<Failure, DesignSegmentsModel>> segments(SegmentsParams params);
  Future<Either<Failure, String>> changeColor(ChangeSegmentColorParams params);
  Future<Either<Failure, String>> changeTexture(
      ChangeSegmentTextureParams params);
  Future<Either<Failure, Unit>> saveProject(SaveDesignParams params);
  Future<Either<Failure, Unit>> exitProject(ExitDesignParams params);
  Future<Either<Failure, Unit>> openProject(OpenDesignParams params);
  Future<Either<Failure, SuggestDesignModel>> suggestDesign(
      SuggestDesignParams params);
  Future<Either<Failure, List<TextureModel>>> getTextures(
      GetTexturesParams params);
}
