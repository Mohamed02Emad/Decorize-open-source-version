import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/common/util/image_util.dart';
import 'package:decorizer/common/util/screenshot_helper.dart';
import 'package:decorizer/user/create_design/domain/params/save_design_params.dart';
import 'package:decorizer/user/create_design/domain/usecases/save_design_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'save_design_state.dart';

@Injectable()
class SaveDesignCubit extends BaseCubit<SaveDesignState> {
  final SaveDesignUsecase saveDesignUsecase;

  SaveDesignCubit(this.saveDesignUsecase) : super(SaveDesignState.initial());

  Future<void> saveDesign({
    required String title,
    required String imageUrl,
  }) async {
    if (state.saveDesignState.isLoading) return;

    callAndFold(
      future:  Future(() async {
        final downloadedImage = await ImageUtil.downloadImage(imageUrl);
        final image =
            await ScreenShotHelper.writeUint8ListToTempFile(downloadedImage);

        final params = SaveDesignParams(title: title, image: image!);

        return saveDesignUsecase(params);
      }),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(saveDesignState: requestState)),
    );
  }
}
