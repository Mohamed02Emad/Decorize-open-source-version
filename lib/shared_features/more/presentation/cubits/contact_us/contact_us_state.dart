part of 'contact_us_cubit.dart';

class ContactUsState extends Equatable {
  final RequestState<Unit> sendMessageState;
  final RequestState<Unit> getContactDataState;

  ContactUsState.initial()
      : sendMessageState = RequestState.initial(),
        getContactDataState = RequestState.initial();
  const ContactUsState(
      {required this.sendMessageState, required this.getContactDataState});

  ContactUsState copyWith({
    RequestState<Unit>? sendMessageState,
    RequestState<Unit>? getContactDataState,
  }) {
    return ContactUsState(
      sendMessageState: sendMessageState ?? this.sendMessageState,
      getContactDataState: getContactDataState ?? this.getContactDataState,
    );
  }

  @override
  List<Object?> get props => [sendMessageState, getContactDataState];
}
