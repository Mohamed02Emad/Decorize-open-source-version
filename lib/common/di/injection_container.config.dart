// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart' as _i605;

import '../../shared_features/auth/data/dataSource/auth_local_data_source.dart'
    as _i453;
import '../../shared_features/auth/data/dataSource/auth_remote_data_source.dart'
    as _i81;
import '../../shared_features/auth/data/repositories/auth_repository.dart'
    as _i688;
import '../../shared_features/auth/data/repositories/local_repository.dart'
    as _i420;
import '../../shared_features/auth/domain/repositories/auth_repository.dart'
    as _i694;
import '../../shared_features/auth/domain/repositories/local_repository.dart'
    as _i847;
import '../../shared_features/auth/domain/usecases/forget_password_use_case.dart'
    as _i761;
import '../../shared_features/auth/domain/usecases/getters/get_cached_user_use_case.dart'
    as _i1003;
import '../../shared_features/auth/domain/usecases/getters/get_is_onboarding_finished_usecase.dart'
    as _i954;
import '../../shared_features/auth/domain/usecases/getters/get_user_token_usecase.dart'
    as _i409;
import '../../shared_features/auth/domain/usecases/login_use_case.dart'
    as _i122;
import '../../shared_features/auth/domain/usecases/register_use_case.dart'
    as _i959;
import '../../shared_features/auth/domain/usecases/reset_password_use_case.dart'
    as _i845;
import '../../shared_features/auth/domain/usecases/setters/set_cached_user_usecase.dart'
    as _i1051;
import '../../shared_features/auth/domain/usecases/setters/set_is_onboarding_finished_usecase.dart'
    as _i352;
import '../../shared_features/auth/domain/usecases/setters/set_user_token_usecase.dart'
    as _i656;
import '../../shared_features/auth/domain/usecases/verify_otp_use_case.dart'
    as _i2;
import '../../shared_features/auth/presentation/cubit/forget_password/forget_password_cubit.dart'
    as _i174;
import '../../shared_features/auth/presentation/cubit/login/login_cubit.dart'
    as _i338;
import '../../shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart'
    as _i899;
import '../../shared_features/auth/presentation/cubit/register/register_cubit.dart'
    as _i619;
import '../../shared_features/auth/presentation/cubit/reset_password/reset_password_cubit.dart'
    as _i890;
import '../../shared_features/auth/presentation/cubit/verify_otp/verify_otp_cubit.dart'
    as _i638;
import '../../shared_features/chat/data/datasources/chat_data_source.dart'
    as _i400;
import '../../shared_features/chat/data/repositories/chat_repository_impl.dart'
    as _i426;
import '../../shared_features/chat/domain/repositories/chat_repository.dart'
    as _i715;
import '../../shared_features/chat/domain/usecases/create_chat_use_case.dart'
    as _i929;
import '../../shared_features/chat/domain/usecases/get_chats_use_case.dart'
    as _i416;
import '../../shared_features/chat/domain/usecases/get_messages_use_case.dart'
    as _i378;
import '../../shared_features/chat/domain/usecases/get_unread_message_count_usecase.dart'
    as _i250;
import '../../shared_features/chat/domain/usecases/send_message_use_case.dart'
    as _i670;
import '../../shared_features/chat/presentation/cubits/chats/chats_cubit.dart'
    as _i77;
import '../../shared_features/chat/presentation/cubits/create_chat/create_chat_cubit.dart'
    as _i1058;
import '../../shared_features/chat/presentation/cubits/messages/messages_cubit.dart'
    as _i802;
import '../../shared_features/chat/presentation/cubits/send_message/send_message_cubit.dart'
    as _i573;
import '../../shared_features/chat/presentation/cubits/unread_message_count/unread_message_count_cubit.dart'
    as _i530;
import '../../shared_features/more/data/datasource/contact_us_datasource.dart'
    as _i314;
import '../../shared_features/more/data/datasource/more_datasource.dart'
    as _i739;
import '../../shared_features/more/data/repository/contact_us_repository_impl.dart'
    as _i680;
import '../../shared_features/more/data/repository/more_repository_impl.dart'
    as _i10;
import '../../shared_features/more/domain/repositories/contact_us_repository.dart'
    as _i462;
import '../../shared_features/more/domain/repositories/more_repository.dart'
    as _i795;
import '../../shared_features/more/domain/usecases/delete_account_use_case.dart'
    as _i290;
import '../../shared_features/more/domain/usecases/get_contact_us_data_use_case.dart'
    as _i93;
import '../../shared_features/more/domain/usecases/get_static_page_use_case.dart'
    as _i109;
import '../../shared_features/more/domain/usecases/logout_use_case.dart'
    as _i34;
import '../../shared_features/more/domain/usecases/send_contact_us_message_use_case.dart'
    as _i493;
import '../../shared_features/more/presentation/cubits/contact_us/contact_us_cubit.dart'
    as _i410;
import '../../shared_features/more/presentation/cubits/more/more_cubit.dart'
    as _i648;
import '../../shared_features/more/presentation/cubits/static_pages/static_pages_cubit.dart'
    as _i219;
import '../../shared_features/notifications/data/datasources/notifications_remote_datasource.dart'
    as _i244;
import '../../shared_features/notifications/data/repositories/notificaions_repository_impl.dart'
    as _i563;
import '../../shared_features/notifications/domain/repositories/notifications_repository.dart'
    as _i317;
import '../../shared_features/notifications/domain/usecases/get_unread_notifications_count_usecase.dart'
    as _i371;
import '../../shared_features/notifications/domain/usecases/mark_notifications_as_read_usecase.dart'
    as _i1037;
import '../../shared_features/notifications/domain/usecases/notifications_usecase.dart'
    as _i875;
import '../../shared_features/notifications/presentation/cubits/mark_as_read/mark_as_read_cubit.dart'
    as _i339;
import '../../shared_features/notifications/presentation/cubits/notifications/notifications_cubit.dart'
    as _i722;
import '../../shared_features/notifications/presentation/cubits/unread_notifications_count/unread_notifications_count_cubit.dart'
    as _i917;
import '../../shared_features/static/data/datasources/static_remote_datasource.dart'
    as _i11;
import '../../shared_features/static/data/repositories/static_repository_impl.dart'
    as _i756;
import '../../shared_features/static/domain/repositories/static_repository.dart'
    as _i422;
import '../../shared_features/static/domain/usecases/categories_usecase.dart'
    as _i699;
import '../../shared_features/static/domain/usecases/cities_usecase.dart'
    as _i303;
import '../../shared_features/static/domain/usecases/governates_usecase.dart'
    as _i1023;
import '../../shared_features/static/domain/usecases/types_usecase.dart'
    as _i579;
import '../../shared_features/static/presentation/cubits/categories/categories_cubit.dart'
    as _i702;
import '../../shared_features/static/presentation/cubits/cities/cities_cubit.dart'
    as _i197;
import '../../shared_features/static/presentation/cubits/governates/governates_cubit.dart'
    as _i202;
import '../../shared_features/static/presentation/cubits/types/types_cubit.dart'
    as _i725;
import '../../user/bottom_navigation/cubits/user_navigation_cubit.dart'
    as _i832;
import '../../user/create_ad/data/datasources/create_ad_remote_datasource.dart'
    as _i359;
import '../../user/create_ad/data/repositories/create_ad_repository_impl.dart'
    as _i95;
import '../../user/create_ad/domain/repositories/create_ad_repository.dart'
    as _i1008;
import '../../user/create_ad/domain/usecases/create_ad_usecase.dart' as _i1029;
import '../../user/create_ad/domain/usecases/update_ad_usecase.dart' as _i416;
import '../../user/create_ad/presentation/cubits/create_ad/create_ad_cubit.dart'
    as _i239;
import '../../user/create_ad/presentation/cubits/upsert_ad/upsert_ad_cubit.dart'
    as _i186;
import '../../user/create_design/data/datasources/create_design_datasource.dart'
    as _i299;
import '../../user/create_design/data/repositories/create_design_repository_impl.dart'
    as _i304;
import '../../user/create_design/domain/repositories/create_design_repository.dart'
    as _i222;
import '../../user/create_design/domain/usecases/change_segment_color_usecase.dart'
    as _i487;
import '../../user/create_design/domain/usecases/change_segment_texture_usecase.dart'
    as _i540;
import '../../user/create_design/domain/usecases/design_segments_usecase.dart'
    as _i969;
import '../../user/create_design/domain/usecases/exit_design_usecase.dart'
    as _i662;
import '../../user/create_design/domain/usecases/get_textures_usecase.dart'
    as _i403;
import '../../user/create_design/domain/usecases/open_design_usecase.dart'
    as _i462;
import '../../user/create_design/domain/usecases/save_design_usecase.dart'
    as _i932;
import '../../user/create_design/domain/usecases/suggest_design_usecase.dart'
    as _i556;
import '../../user/create_design/domain/usecases/upload_ai_image_usecase.dart'
    as _i801;
import '../../user/create_design/presentation/cubits/design_segments/design_segments_cubit.dart'
    as _i901;
import '../../user/create_design/presentation/cubits/exit_design/exit_design_cubit.dart'
    as _i668;
import '../../user/create_design/presentation/cubits/get_textures/get_textures_cubit.dart'
    as _i33;
import '../../user/create_design/presentation/cubits/open_design/open_design_cubit.dart'
    as _i734;
import '../../user/create_design/presentation/cubits/save_design/save_design_cubit.dart'
    as _i636;
import '../../user/create_design/presentation/cubits/suggest_design_cubit/suggest_design_cubit.dart'
    as _i929;
import '../../user/create_design/presentation/cubits/upload_ai_image/upload_ai_image_cubit.dart'
    as _i90;
import '../../user/edit_profile/data/datasources/edit_profile_remote_datasource.dart'
    as _i630;
import '../../user/edit_profile/data/repositories/edit_profile_repository_impl.dart'
    as _i803;
import '../../user/edit_profile/domain/repositories/edit_profile_repository.dart'
    as _i423;
import '../../user/edit_profile/domain/usecases/change_password_usecase.dart'
    as _i674;
import '../../user/edit_profile/domain/usecases/get_profile_usecase.dart'
    as _i448;
import '../../user/edit_profile/domain/usecases/update_profile_usecase.dart'
    as _i816;
import '../../user/edit_profile/presentation/cubits/change_password/change_password_cubit.dart'
    as _i991;
import '../../user/edit_profile/presentation/cubits/get_profile/get_profile_cubit.dart'
    as _i697;
import '../../user/edit_profile/presentation/cubits/update_profile/update_profile_cubit.dart'
    as _i44;
import '../../user/home/data/dataSources/home_datasource.dart' as _i784;
import '../../user/home/data/dataSources/home_remote_datasource.dart' as _i523;
import '../../user/home/data/repositories/home_repository_impl.dart' as _i908;
import '../../user/home/domain/repositories/home_repository.dart' as _i198;
import '../../user/home/domain/usecases/all_designs_usecase.dart' as _i860;
import '../../user/home/domain/usecases/get_saved_designs_usecase.dart'
    as _i794;
import '../../user/home/domain/usecases/suggested_designs_usecase.dart'
    as _i791;
import '../../user/home/presentation/cubits/all_designs/all_designs_cubit.dart'
    as _i118;
import '../../user/home/presentation/cubits/home/home_cubit.dart' as _i42;
import '../../user/orders/data/datasources/user_orders_remote_datasource.dart'
    as _i227;
import '../../user/orders/data/repositories/user_orders_repository_impl.dart'
    as _i41;
import '../../user/orders/domain/repositories/user_orders_repository.dart'
    as _i1037;
import '../../user/orders/domain/usecases/add_rate_usecase.dart' as _i177;
import '../../user/orders/domain/usecases/delete_user_order_usecase.dart'
    as _i806;
import '../../user/orders/domain/usecases/get_order_offers_usecase.dart'
    as _i282;
import '../../user/orders/domain/usecases/update_offer_status_usecase.dart'
    as _i529;
import '../../user/orders/domain/usecases/update_order_status_usecase.dart'
    as _i172;
import '../../user/orders/domain/usecases/update_user_order_usecase.dart'
    as _i1022;
import '../../user/orders/domain/usecases/user_order_details_usecase.dart'
    as _i44;
import '../../user/orders/domain/usecases/user_orders_usecase.dart' as _i218;
import '../../user/orders/presentation/cubits/add_rate/add_rate_cubit.dart'
    as _i31;
import '../../user/orders/presentation/cubits/delete_user_order/delete_user_order_cubit.dart'
    as _i415;
import '../../user/orders/presentation/cubits/get_order_offers/get_order_offers_cubit.dart'
    as _i929;
import '../../user/orders/presentation/cubits/get_orders/get_user_orders_cubit.dart'
    as _i961;
import '../../user/orders/presentation/cubits/update_offer_status/update_offer_status_cubit.dart'
    as _i437;
import '../../user/orders/presentation/cubits/update_order_status/update_order_status_cubit.dart'
    as _i117;
import '../../user/orders/presentation/cubits/user_order_details/user_order_details_cubit.dart'
    as _i449;
import '../../user/saved_designs/data/datasources/saved_designs_datasource.dart'
    as _i865;
import '../../user/saved_designs/data/repositories/saved_designs_repository_impl.dart'
    as _i1;
import '../../user/saved_designs/domain/repositories/saved_designs_repository.dart'
    as _i110;
import '../../user/saved_designs/domain/usecases/get_saved_designs_usecase.dart'
    as _i685;
import '../../user/saved_designs/presentation/cubits/saved_designs_cubit.dart'
    as _i753;
import '../../worker/bottom_navigation/cubit/worker_navigation_cubit.dart'
    as _i1038;
import '../../worker/home/data/datasource/worker_home_remote_data_source.dart'
    as _i327;
import '../../worker/home/data/repository/worker_orders_repository_imp.dart'
    as _i985;
import '../../worker/home/domain/repository/worker_home_repository.dart'
    as _i776;
import '../../worker/home/domain/usecases/get_worker_order_details_usecase.dart'
    as _i916;
import '../../worker/home/domain/usecases/get_worker_orders_usecase.dart'
    as _i927;
import '../../worker/home/domain/usecases/store_worker_offer_usecase.dart'
    as _i348;
import '../../worker/home/presentation/cubit/get_order_details/get_worker_order_details_cubit.dart'
    as _i244;
import '../../worker/home/presentation/cubit/get_orders/get_worker_orders_cubit.dart'
    as _i217;
import '../../worker/home/presentation/cubit/store_offer/store_offer_cubit.dart'
    as _i505;
import '../../worker/offers/data/datatsource/worker_offers_remote_data_source.dart'
    as _i630;
import '../../worker/offers/data/repository/worker_offers_repository_imp.dart'
    as _i727;
import '../../worker/offers/domain/repository/worker_offers_repository.dart'
    as _i343;
import '../../worker/offers/domain/usecases/delete_worker_offer_usecase.dart'
    as _i971;
import '../../worker/offers/domain/usecases/get_worker_offers_usecase.dart'
    as _i820;
import '../../worker/offers/presentation/cubit/current_offers_cubit/current_offers_cubit.dart'
    as _i285;
import '../../worker/offers/presentation/cubit/delete_worker_offer_cubit/delete_worker_offer_cubit.dart'
    as _i83;
import '../../worker/offers/presentation/cubit/get_worker_offers/get_worker_offer_cubit.dart'
    as _i870;
import '../../worker/offers/presentation/cubit/previous_offers_cubit/previous_offers_cubit.dart'
    as _i242;
import '../../worker/profile/data/datasources/worker_profile_remote_datasource.dart'
    as _i555;
import '../../worker/profile/data/repository/worker_profile_repository_imp.dart'
    as _i597;
import '../../worker/profile/domain/repository/worker_profile_repository.dart'
    as _i20;
import '../../worker/profile/domain/usecases/get_worker_profile_usecase.dart'
    as _i793;
import '../../worker/profile/presentation/cubit/get_profile_cubit/worker_profile_cubit.dart'
    as _i980;
import '../util/api_basehelper.dart' as _i452;
import '../util/device_and_app_info_util.dart' as _i69;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i832.UserNavigationCubit>(() => _i832.UserNavigationCubit());
    gh.singleton<_i452.ApiBaseHelper>(() => _i452.ApiBaseHelper());
    gh.singleton<_i69.DeviceAndAppInfoUtil>(() => _i69.DeviceAndAppInfoUtil());
    gh.singleton<_i1038.WorkerNavigationCubit>(
        () => _i1038.WorkerNavigationCubit());
    gh.factory<_i314.ContactUsDatasource>(
        () => _i314.ContactUsDatasourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i81.AuthRemoteDataSource>(
        () => _i81.AuthRemoteDataSourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i453.AuthLocalDataSource>(
        () => _i453.AuthLocalDataSourceImpl());
    gh.factory<_i400.ChatDataSource>(
        () => _i400.ChatDataSourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i739.MoreDatasource>(
        () => _i739.MoreDatasourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i847.LocalRepository>(
        () => _i420.LocalRepositoryImpl(gh<_i453.AuthLocalDataSource>()));
    gh.factory<_i715.ChatRepository>(
        () => _i426.ChatRepositoryImpl(dataSource: gh<_i400.ChatDataSource>()));
    gh.factory<_i299.CreateDesignDatasource>(
        () => _i299.CreateDesignDatasourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i784.HomeDatasource>(
        () => _i784.HomeDatasourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i929.CreateChatUseCase>(
        () => _i929.CreateChatUseCase(gh<_i715.ChatRepository>()));
    gh.factory<_i670.SendMessageUseCase>(
        () => _i670.SendMessageUseCase(gh<_i715.ChatRepository>()));
    gh.factory<_i523.HomeRemoteDataSource>(
        () => _i523.HomeRemoteDataSourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i359.CreateAdRemoteDatasource>(
        () => _i359.CreateAdRemoteDatasourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i327.WorkerHomeRemoteDataSource>(() =>
        _i327.WorkerHomeRemoteDataSourceImpl(
            apiHelper: gh<_i452.ApiBaseHelper>()));
    gh.factory<_i865.SavedDesignsDataSource>(
        () => _i865.SavedDesignsDataSourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i555.WorkerProfileRemoteDataSource>(() =>
        _i555.WorkerProfileRemoteDataSourceImpl(
            apiHelper: gh<_i452.ApiBaseHelper>()));
    gh.factory<_i573.SendMessageCubit>(
        () => _i573.SendMessageCubit(gh<_i670.SendMessageUseCase>()));
    gh.factory<_i11.StaticRemoteDataSource>(
        () => _i11.StaticRemoteDataSourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i198.HomeRepository>(
        () => _i908.HomeRepositoryImpl(gh<_i523.HomeRemoteDataSource>()));
    gh.factory<_i630.WorkerOffersRemoteDataSource>(() =>
        _i630.WorkerOffersRemoteDataSourceImpl(
            apiHelper: gh<_i452.ApiBaseHelper>()));
    gh.factory<_i227.UserOrdersRemoteDatasource>(() =>
        _i227.UserOrdersRemoteDatasourceImpl(
            apiHelper: gh<_i452.ApiBaseHelper>()));
    gh.factory<_i222.CreateDesignRepository>(() =>
        _i304.CreateDesignRepositoryImpl(gh<_i299.CreateDesignDatasource>()));
    gh.factory<_i630.EditProfileRemoteDatasource>(() =>
        _i630.EditProfileRemoteDatasourceImpl(
            apiHelper: gh<_i452.ApiBaseHelper>()));
    gh.factory<_i462.ContactUsRepository>(() => _i680.ContactUsRepositoryImpl(
        dataSource: gh<_i314.ContactUsDatasource>()));
    gh.factory<_i110.SavedDesignsRepository>(() =>
        _i1.SavedDesignsRepositoryImpl(gh<_i865.SavedDesignsDataSource>()));
    gh.factory<_i694.AuthRepository>(() =>
        _i688.AuthRepositoryImpl(dataSource: gh<_i81.AuthRemoteDataSource>()));
    gh.factory<_i244.NotificationsRemoteDataSource>(() =>
        _i244.NotificationsRemoteDataSourceImpl(gh<_i452.ApiBaseHelper>()));
    gh.factory<_i378.GetMessagesUseCase>(() =>
        _i378.GetMessagesUseCase(chatRepository: gh<_i715.ChatRepository>()));
    gh.factory<_i416.GetChatsUseCase>(() =>
        _i416.GetChatsUseCase(chatRepository: gh<_i715.ChatRepository>()));
    gh.factory<_i250.GetUnreadMessageCountUsecase>(() =>
        _i250.GetUnreadMessageCountUsecase(
            chatRepository: gh<_i715.ChatRepository>()));
    gh.factory<_i795.MoreRepository>(() => _i10.MoreRepositoryImpl(
          dataSource: gh<_i739.MoreDatasource>(),
          localDataSource: gh<_i453.AuthLocalDataSource>(),
        ));
    gh.factory<_i802.MessagesCubit>(() => _i802.MessagesCubit(
          gh<_i378.GetMessagesUseCase>(),
          gh<_i605.PusherChannelsFlutter>(),
        ));
    gh.factory<_i1037.UserOrdersRepository>(() => _i41.UserOrdersRepositoryImpl(
        remoteDatasource: gh<_i227.UserOrdersRemoteDatasource>()));
    gh.factory<_i34.LogoutUseCase>(
        () => _i34.LogoutUseCase(gh<_i795.MoreRepository>()));
    gh.factory<_i109.GetStaticPageUseCase>(
        () => _i109.GetStaticPageUseCase(gh<_i795.MoreRepository>()));
    gh.factory<_i290.DeleteAccountUseCase>(
        () => _i290.DeleteAccountUseCase(gh<_i795.MoreRepository>()));
    gh.factory<_i422.StaticRepository>(
        () => _i756.StaticRepositoryImpl(gh<_i11.StaticRemoteDataSource>()));
    gh.factory<_i343.WorkerOffersRepository>(() =>
        _i727.WorkerOffersRepositoryImp(
            remoteDataSource: gh<_i630.WorkerOffersRemoteDataSource>()));
    gh.factory<_i352.SetIsOnboardingFinishedUseCase>(() =>
        _i352.SetIsOnboardingFinishedUseCase(gh<_i847.LocalRepository>()));
    gh.factory<_i1051.SetCachedUserUseCase>(
        () => _i1051.SetCachedUserUseCase(gh<_i847.LocalRepository>()));
    gh.factory<_i656.SetUserTokenUseCase>(
        () => _i656.SetUserTokenUseCase(gh<_i847.LocalRepository>()));
    gh.factory<_i409.GetUserTokenUseCase>(
        () => _i409.GetUserTokenUseCase(gh<_i847.LocalRepository>()));
    gh.factory<_i954.GetIsOnboardingFinishedUseCase>(() =>
        _i954.GetIsOnboardingFinishedUseCase(gh<_i847.LocalRepository>()));
    gh.factory<_i1003.GetCachedUserUseCase>(
        () => _i1003.GetCachedUserUseCase(gh<_i847.LocalRepository>()));
    gh.factory<_i579.TypesUsecase>(
        () => _i579.TypesUsecase(gh<_i422.StaticRepository>()));
    gh.factory<_i1023.GovernatesUsecase>(
        () => _i1023.GovernatesUsecase(gh<_i422.StaticRepository>()));
    gh.factory<_i303.CitiesUsecase>(
        () => _i303.CitiesUsecase(gh<_i422.StaticRepository>()));
    gh.factory<_i699.CategoriesUsecase>(
        () => _i699.CategoriesUsecase(gh<_i422.StaticRepository>()));
    gh.factory<_i761.ForgetPasswordUseCase>(
        () => _i761.ForgetPasswordUseCase(gh<_i694.AuthRepository>()));
    gh.factory<_i959.RegisterUseCase>(
        () => _i959.RegisterUseCase(gh<_i694.AuthRepository>()));
    gh.factory<_i122.LoginUseCase>(
        () => _i122.LoginUseCase(gh<_i694.AuthRepository>()));
    gh.factory<_i845.ResetPasswordUseCase>(
        () => _i845.ResetPasswordUseCase(gh<_i694.AuthRepository>()));
    gh.factory<_i2.VerifyOtpUseCase>(
        () => _i2.VerifyOtpUseCase(gh<_i694.AuthRepository>()));
    gh.factory<_i20.WorkerProfileRepository>(() =>
        _i597.WorkerProfileRepositoryImp(
            gh<_i555.WorkerProfileRemoteDataSource>()));
    gh.factory<_i1058.CreateChatCubit>(
        () => _i1058.CreateChatCubit(gh<_i929.CreateChatUseCase>()));
    gh.factory<_i801.UploadAiImageUsecase>(
        () => _i801.UploadAiImageUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i662.ExitDesignUsecase>(
        () => _i662.ExitDesignUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i487.ChangeSegmentColorUsecase>(() =>
        _i487.ChangeSegmentColorUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i969.DesignSegmentsUsecase>(
        () => _i969.DesignSegmentsUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i540.ChangeSegmentTextureUsecase>(() =>
        _i540.ChangeSegmentTextureUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i932.SaveDesignUsecase>(
        () => _i932.SaveDesignUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i462.OpenDesignUsecase>(
        () => _i462.OpenDesignUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i403.GetTexturesUsecase>(
        () => _i403.GetTexturesUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i860.AllDesignsUsecase>(
        () => _i860.AllDesignsUsecase(gh<_i198.HomeRepository>()));
    gh.factory<_i791.SuggestedDesignsUsecase>(
        () => _i791.SuggestedDesignsUsecase(gh<_i198.HomeRepository>()));
    gh.factory<_i734.OpenDesignCubit>(
        () => _i734.OpenDesignCubit(gh<_i462.OpenDesignUsecase>()));
    gh.factory<_i90.UploadAiImageCubit>(
        () => _i90.UploadAiImageCubit(gh<_i801.UploadAiImageUsecase>()));
    gh.factory<_i776.WorkerHomeRepository>(() => _i985.WorkerHomeRepositoryImp(
        remoteDataSource: gh<_i327.WorkerHomeRemoteDataSource>()));
    gh.factory<_i282.GetOrderOffersUsecase>(() => _i282.GetOrderOffersUsecase(
        userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i529.UpdateOfferStatusUsecase>(() =>
        _i529.UpdateOfferStatusUsecase(
            userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i806.DeleteUserOrderUsecase>(() => _i806.DeleteUserOrderUsecase(
        userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i218.UserOrdersUsecase>(() => _i218.UserOrdersUsecase(
        userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i44.UserOrderDetailsUsecase>(() => _i44.UserOrderDetailsUsecase(
        userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i177.AddRateUsecase>(() => _i177.AddRateUsecase(
        userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i1022.UpdateUserOrderUsecase>(() =>
        _i1022.UpdateUserOrderUsecase(
            userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i172.UpdateOrderStatusUsecase>(() =>
        _i172.UpdateOrderStatusUsecase(
            userOrdersRepository: gh<_i1037.UserOrdersRepository>()));
    gh.factory<_i636.SaveDesignCubit>(
        () => _i636.SaveDesignCubit(gh<_i932.SaveDesignUsecase>()));
    gh.factory<_i794.GetSavedDesignsUsecase>(
        () => _i794.GetSavedDesignsUsecase(gh<_i198.HomeRepository>()));
    gh.factory<_i42.HomeCubit>(() => _i42.HomeCubit(
          gh<_i699.CategoriesUsecase>(),
          gh<_i791.SuggestedDesignsUsecase>(),
          gh<_i794.GetSavedDesignsUsecase>(),
        ));
    gh.factory<_i117.UpdateOrderStatusCubit>(() =>
        _i117.UpdateOrderStatusCubit(gh<_i172.UpdateOrderStatusUsecase>()));
    gh.factory<_i1008.CreateAdRepository>(() =>
        _i95.CreateAdRepositoryImpl(gh<_i359.CreateAdRemoteDatasource>()));
    gh.factory<_i556.SuggestDesignUsecase>(
        () => _i556.SuggestDesignUsecase(gh<_i222.CreateDesignRepository>()));
    gh.factory<_i416.UpdateAdUsecase>(
        () => _i416.UpdateAdUsecase(gh<_i1008.CreateAdRepository>()));
    gh.factory<_i1029.CreateAdUsecase>(
        () => _i1029.CreateAdUsecase(gh<_i1008.CreateAdRepository>()));
    gh.singleton<_i899.LoginInfoCubit>(() => _i899.LoginInfoCubit(
          gh<_i954.GetIsOnboardingFinishedUseCase>(),
          gh<_i352.SetIsOnboardingFinishedUseCase>(),
          gh<_i409.GetUserTokenUseCase>(),
          gh<_i1003.GetCachedUserUseCase>(),
        ));
    gh.factory<_i93.GetContactUsDataUseCase>(
        () => _i93.GetContactUsDataUseCase(gh<_i462.ContactUsRepository>()));
    gh.factory<_i493.SendContactUsMessageUseCase>(() =>
        _i493.SendContactUsMessageUseCase(gh<_i462.ContactUsRepository>()));
    gh.factory<_i449.UserOrderDetailsCubit>(
        () => _i449.UserOrderDetailsCubit(gh<_i44.UserOrderDetailsUsecase>()));
    gh.factory<_i685.GetSavedDesignsUsecase>(
        () => _i685.GetSavedDesignsUsecase(gh<_i110.SavedDesignsRepository>()));
    gh.factory<_i890.ResetPasswordCubit>(
        () => _i890.ResetPasswordCubit(gh<_i845.ResetPasswordUseCase>()));
    gh.factory<_i317.NotificationsRepository>(() =>
        _i563.NotificaionsRepositoryImpl(
            gh<_i244.NotificationsRemoteDataSource>()));
    gh.factory<_i753.SavedDesignsCubit>(
        () => _i753.SavedDesignsCubit(gh<_i685.GetSavedDesignsUsecase>()));
    gh.factory<_i901.DesignSegmentsCubit>(() => _i901.DesignSegmentsCubit(
          gh<_i969.DesignSegmentsUsecase>(),
          gh<_i487.ChangeSegmentColorUsecase>(),
          gh<_i540.ChangeSegmentTextureUsecase>(),
        ));
    gh.factory<_i971.DeleteWorkerOfferUsecase>(() =>
        _i971.DeleteWorkerOfferUsecase(
            workerOffersRepository: gh<_i343.WorkerOffersRepository>()));
    gh.factory<_i820.GetWorkerOffersUseCase>(() => _i820.GetWorkerOffersUseCase(
        workerOffersRepository: gh<_i343.WorkerOffersRepository>()));
    gh.factory<_i423.EditProfileRepository>(
        () => _i803.EditProfileRepositoryImpl(
              remoteDatasource: gh<_i630.EditProfileRemoteDatasource>(),
              setCachedUserUseCase: gh<_i1051.SetCachedUserUseCase>(),
            ));
    gh.factory<_i174.ForgetPasswordCubit>(
        () => _i174.ForgetPasswordCubit(gh<_i761.ForgetPasswordUseCase>()));
    gh.factory<_i186.UpsertAdCubit>(() => _i186.UpsertAdCubit(
          gh<_i1029.CreateAdUsecase>(),
          gh<_i416.UpdateAdUsecase>(),
        ));
    gh.factory<_i648.MoreCubit>(() => _i648.MoreCubit(
          gh<_i34.LogoutUseCase>(),
          gh<_i290.DeleteAccountUseCase>(),
        ));
    gh.factory<_i410.ContactUsCubit>(() => _i410.ContactUsCubit(
          gh<_i93.GetContactUsDataUseCase>(),
          gh<_i493.SendContactUsMessageUseCase>(),
        ));
    gh.factory<_i77.ChatsCubit>(() => _i77.ChatsCubit(
          gh<_i416.GetChatsUseCase>(),
          gh<_i605.PusherChannelsFlutter>(),
        ));
    gh.factory<_i371.GetUnreadNotificationsCountUsecase>(() =>
        _i371.GetUnreadNotificationsCountUsecase(
            notificationsRepository: gh<_i317.NotificationsRepository>()));
    gh.factory<_i875.NotificationsUsecase>(() => _i875.NotificationsUsecase(
        notificationsRepository: gh<_i317.NotificationsRepository>()));
    gh.factory<_i1037.MarkNotificationsAsReadUsecase>(() =>
        _i1037.MarkNotificationsAsReadUsecase(
            notificationsRepository: gh<_i317.NotificationsRepository>()));
    gh.factory<_i702.CategoriesCubit>(
        () => _i702.CategoriesCubit(gh<_i699.CategoriesUsecase>()));
    gh.singleton<_i961.GetUserOrdersCubit>(
        () => _i961.GetUserOrdersCubit(gh<_i218.UserOrdersUsecase>()));
    gh.factory<_i197.CitiesCubit>(
        () => _i197.CitiesCubit(gh<_i303.CitiesUsecase>()));
    gh.factory<_i638.VerifyOtpCubit>(
        () => _i638.VerifyOtpCubit(gh<_i2.VerifyOtpUseCase>()));
    gh.lazySingleton<_i530.UnreadMessageCountCubit>(() =>
        _i530.UnreadMessageCountCubit(
            gh<_i250.GetUnreadMessageCountUsecase>()));
    gh.factory<_i437.UpdateOfferStatusCubit>(() =>
        _i437.UpdateOfferStatusCubit(gh<_i529.UpdateOfferStatusUsecase>()));
    gh.factory<_i619.RegisterCubit>(() => _i619.RegisterCubit(
          gh<_i959.RegisterUseCase>(),
          gh<_i656.SetUserTokenUseCase>(),
          gh<_i1051.SetCachedUserUseCase>(),
        ));
    gh.factory<_i793.GetWorkerProfileUseCase>(() =>
        _i793.GetWorkerProfileUseCase(gh<_i20.WorkerProfileRepository>()));
    gh.factory<_i219.StaticPagesCubit>(
        () => _i219.StaticPagesCubit(gh<_i109.GetStaticPageUseCase>()));
    gh.factory<_i725.TypesCubit>(
        () => _i725.TypesCubit(gh<_i579.TypesUsecase>()));
    gh.factory<_i118.AllDesignsCubit>(
        () => _i118.AllDesignsCubit(gh<_i860.AllDesignsUsecase>()));
    gh.factory<_i415.DeleteUserOrderCubit>(
        () => _i415.DeleteUserOrderCubit(gh<_i806.DeleteUserOrderUsecase>()));
    gh.factory<_i31.AddRateCubit>(
        () => _i31.AddRateCubit(gh<_i177.AddRateUsecase>()));
    gh.factory<_i202.GovernatesCubit>(
        () => _i202.GovernatesCubit(gh<_i1023.GovernatesUsecase>()));
    gh.factory<_i242.GetPreviousOffersCubit>(() => _i242.GetPreviousOffersCubit(
          gh<_i820.GetWorkerOffersUseCase>(),
          gh<_i899.LoginInfoCubit>(),
        ));
    gh.factory<_i285.GetCurrentOffersCubit>(() => _i285.GetCurrentOffersCubit(
          gh<_i820.GetWorkerOffersUseCase>(),
          gh<_i899.LoginInfoCubit>(),
        ));
    gh.factory<_i338.LoginCubit>(() => _i338.LoginCubit(
          gh<_i122.LoginUseCase>(),
          gh<_i656.SetUserTokenUseCase>(),
          gh<_i1051.SetCachedUserUseCase>(),
        ));
    gh.factory<_i339.MarkAsReadCubit>(() =>
        _i339.MarkAsReadCubit(gh<_i1037.MarkNotificationsAsReadUsecase>()));
    gh.factory<_i668.ExitDesignCubit>(
        () => _i668.ExitDesignCubit(gh<_i662.ExitDesignUsecase>()));
    gh.factory<_i348.StoreWorkerOfferUseCase>(() =>
        _i348.StoreWorkerOfferUseCase(
            workerHomeRepository: gh<_i776.WorkerHomeRepository>()));
    gh.factory<_i927.GetWorkerOrdersUseCase>(() => _i927.GetWorkerOrdersUseCase(
        workerHomeRepository: gh<_i776.WorkerHomeRepository>()));
    gh.factory<_i916.WorkerOrderDetailsUsecase>(() =>
        _i916.WorkerOrderDetailsUsecase(
            workerHomeRepository: gh<_i776.WorkerHomeRepository>()));
    gh.factory<_i33.GetTexturesCubit>(
        () => _i33.GetTexturesCubit(gh<_i403.GetTexturesUsecase>()));
    gh.factory<_i929.GetOrderOffersCubit>(
        () => _i929.GetOrderOffersCubit(gh<_i282.GetOrderOffersUsecase>()));
    gh.factory<_i816.UpdateProfileUsecase>(() => _i816.UpdateProfileUsecase(
        editProfileRepository: gh<_i423.EditProfileRepository>()));
    gh.factory<_i448.GetProfileUsecase>(() => _i448.GetProfileUsecase(
        editProfileRepository: gh<_i423.EditProfileRepository>()));
    gh.lazySingleton<_i917.UnreadNotificationsCountCubit>(() =>
        _i917.UnreadNotificationsCountCubit(
            gh<_i371.GetUnreadNotificationsCountUsecase>()));
    gh.factory<_i83.DeleteWorkerOfferCubit>(() =>
        _i83.DeleteWorkerOfferCubit(gh<_i971.DeleteWorkerOfferUsecase>()));
    gh.factory<_i697.GetProfileCubit>(
        () => _i697.GetProfileCubit(gh<_i448.GetProfileUsecase>()));
    gh.factory<_i929.SuggestDesignCubit>(
        () => _i929.SuggestDesignCubit(gh<_i556.SuggestDesignUsecase>()));
    gh.factory<_i239.CreateAdCubit>(
        () => _i239.CreateAdCubit(gh<_i1029.CreateAdUsecase>()));
    gh.factory<_i980.WorkerProfileCubit>(() => _i980.WorkerProfileCubit(
          gh<_i793.GetWorkerProfileUseCase>(),
          gh<_i899.LoginInfoCubit>(),
        ));
    gh.factory<_i870.GetWorkerOffersCubit>(
        () => _i870.GetWorkerOffersCubit(gh<_i820.GetWorkerOffersUseCase>()));
    gh.factory<_i244.WorkerOrderDetailsCubit>(() =>
        _i244.WorkerOrderDetailsCubit(gh<_i916.WorkerOrderDetailsUsecase>()));
    gh.factory<_i217.GetWorkerOrdersCubit>(
        () => _i217.GetWorkerOrdersCubit(gh<_i927.GetWorkerOrdersUseCase>()));
    gh.factory<_i674.ChangePasswordUseCase>(
        () => _i674.ChangePasswordUseCase(gh<_i423.EditProfileRepository>()));
    gh.factory<_i991.ChangePasswordCubit>(
        () => _i991.ChangePasswordCubit(gh<_i674.ChangePasswordUseCase>()));
    gh.factory<_i722.NotificationsCubit>(
        () => _i722.NotificationsCubit(gh<_i875.NotificationsUsecase>()));
    gh.factory<_i44.UpdateProfileCubit>(
        () => _i44.UpdateProfileCubit(gh<_i816.UpdateProfileUsecase>()));
    gh.factory<_i505.StoreOfferCubit>(
        () => _i505.StoreOfferCubit(gh<_i348.StoreWorkerOfferUseCase>()));
    return this;
  }
}
