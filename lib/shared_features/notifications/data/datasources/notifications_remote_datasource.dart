import 'package:decorizer/common/data/remote/datasource_result.dart';
import 'package:decorizer/common/util/api_basehelper.dart';
import 'package:decorizer/shared_features/notifications/data/notifications_urls.dart';
import 'package:decorizer/shared_features/notifications/domain/params/get_notifications_params.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationsRemoteDataSource {
  DatasourceResult getNotifications(GetNotificationsParams params);
  DatasourceResult getUnreadCount();
  DatasourceResult markAsRead();
}

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl extends NotificationsRemoteDataSource {
  final ApiBaseHelper apiHelper;

  NotificationsRemoteDataSourceImpl(this.apiHelper);

  @override
  DatasourceResult getNotifications(GetNotificationsParams params) {
    return apiHelper.get(
        url: NotificationsUrls.getNotifications,
        queryParameters: params.toJson());
  }

  @override
  DatasourceResult getUnreadCount() {
    return apiHelper.get(url: NotificationsUrls.getUnreadCount);
  }

  @override
  DatasourceResult markAsRead() {
    return apiHelper.get(url: NotificationsUrls.markAsRead);
  }
}
