import '../enums/contact_us_message_type.dart';

class ContactUsParams {
  final String name, phone, message, email;
  final ContactUsMessageType type;

  ContactUsParams(
      {required this.name,
      required this.phone,
      required this.message,
      required this.email,
      required this.type});

  Map<String, dynamic> toBody() {
    return {
      'name': name,
      'phone': phone,
      'message': message,
      'email': email,
      'type': type.apiName,
    };
  }
}
