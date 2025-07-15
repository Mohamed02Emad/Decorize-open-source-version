import '../enums/static_page_type.dart';

class StaticPagesParams {
  final StaticPageType type;

  StaticPagesParams({required this.type});
  Map<String, dynamic> toJson() {
    return {
      'type': type.apiName,
    };
  }
}
