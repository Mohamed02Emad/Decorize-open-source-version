import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';

enum DesignMethod{
  suggest , designByYourSelf;

  String get displayName => switch(this){
    DesignMethod.suggest => LocaleKeys.create_design_suggest_design.tr(),
    DesignMethod.designByYourSelf =>  LocaleKeys.create_design_design_yourself.tr(),
  };
}
