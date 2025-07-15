import 'package:injectable/injectable.dart';

import '../../../../common/data/remote/datasource_result.dart';
import '../../../../common/util/api_basehelper.dart';
import '../../domain/params/contact_us_params.dart';
import '../more_end_points.dart';

abstract class ContactUsDatasource {
  DatasourceResult getContactUsData();

  DatasourceResult sendContactUsMessage({required ContactUsParams params});
}

@Injectable(as: ContactUsDatasource)
class ContactUsDatasourceImpl extends ContactUsDatasource {
  final ApiBaseHelper helper;

  ContactUsDatasourceImpl(this.helper);

  @override
  DatasourceResult getContactUsData() async {
    return await helper.get(
      url: MoreEndPoints.contactUsDataApi,
    );
  }

  @override
  DatasourceResult sendContactUsMessage(
      {required ContactUsParams params}) async {
    final body = params.toBody();
    return await helper.post(
      url: MoreEndPoints.sendMessageApi,
      body: body,
    );
  }
}
