import 'package:decorizer/common/common.dart';
import 'package:equatable/equatable.dart';

LocalizedTextModel localizedTextModelFromJson(dynamic json) {
  return LocalizedTextModel.fromJson(json);
}

class LocalizedTextModel extends Equatable {
  final String ar;
  final String en;

  const LocalizedTextModel({required this.ar, required this.en});

  factory LocalizedTextModel.fromJson(dynamic json) {
    return LocalizedTextModel(
      ar: json['ar'] as String? ?? '',
      en: json['en'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ar': ar, 'en': en};
  }

  String trans() => Nav.globalContext.isArabic ? ar : en;

  const LocalizedTextModel.empty()
      : ar = '',
        en = '';

  @override
  List<Object?> get props => [ar, en];
}
