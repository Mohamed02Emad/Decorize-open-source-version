import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:decorizer/common/base/baseCubit.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/base/usecase.dart';
import '../../../../../common/data/remote/request_state.dart';
import '../../../domain/params/contact_us_params.dart';
import '../../../domain/usecases/get_contact_us_data_use_case.dart';
import '../../../domain/usecases/send_contact_us_message_use_case.dart';

part 'contact_us_state.dart';

@Injectable()
class ContactUsCubit extends BaseCubit<ContactUsState> {
  ContactUsCubit(
      this._getContactUsDataUseCase, this._sendContactUsMessageUseCase)
      : super(ContactUsState.initial());
  final GetContactUsDataUseCase _getContactUsDataUseCase;
  final SendContactUsMessageUseCase _sendContactUsMessageUseCase;

  Future<void> getContactUsData() async {
    if (state.getContactDataState.isLoading) return;
    callAndFold(
      future: _getContactUsDataUseCase(NoParams()),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(getContactDataState: requestState));
      },
    );
  }

  Future<void> sendContactUsMessage({required ContactUsParams params}) async {
    if (state.sendMessageState.isLoading) return;
    callAndFold(
      future: _sendContactUsMessageUseCase(params),
      onDefaultEmit: (requestState) {
        emit(state.copyWith(sendMessageState: requestState));
      },
    );
  }
}
