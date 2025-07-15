import '../../../../common/base_response.dart';

class StaticPageResponse extends BaseResponse {
  final String data;

  StaticPageResponse({super.message, required super.code, required this.data});

  factory StaticPageResponse.fromJson(Map<String, dynamic> json) =>
      StaticPageResponse(
          message: json["message"],
          data: json["data"]["value"],
          code: json['code']);

  @override
  Map<String, dynamic> toJson() => {"message": message};
}
