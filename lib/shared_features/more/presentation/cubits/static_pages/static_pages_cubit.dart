import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/static_page_response.dart';
import '../../../domain/params/static_pages_params.dart';
import '../../../domain/usecases/get_static_page_use_case.dart';

part 'static_pages_state.dart';

@Injectable()
class StaticPagesCubit extends BaseCubit<StaticPagesState> {
  StaticPagesCubit(this._getStaticPageUseCase)
      : super(StaticPagesState.initial());
  final GetStaticPageUseCase _getStaticPageUseCase;

  Future<void> getStaticPage(StaticPagesParams params) async {
    if (state.staticPagesState.isLoading) return;
    callAndFold(
      future: _getStaticPageUseCase(params),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(staticPagesState: requestState));
      },
    );
  }
}
