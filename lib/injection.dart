import 'package:get_it/get_it.dart';
import 'package:real_estate_app/core/routes/app_routers.dart';
import 'package:real_estate_app/features/authentication/data/auth_repository_impl.dart';
import 'package:real_estate_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:real_estate_app/features/authentication/domain/usecases/login_with_email.dart';
import 'package:real_estate_app/features/authentication/domain/usecases/logout.dart';
import 'package:real_estate_app/features/authentication/domain/usecases/register_with_email.dart';
import 'package:real_estate_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:real_estate_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:real_estate_app/features/messaging/data/datasources/chat_remote_data_source_impl.dart';
import 'package:real_estate_app/features/messaging/domain/datasources/chat_remote_data_source.dart';
import 'package:real_estate_app/features/messaging/data/repositories/chat_repository_impl.dart';
import 'package:real_estate_app/features/messaging/domain/repositories/chat_repository.dart';
import 'package:real_estate_app/features/messaging/domain/usecases/get_chat_messages.dart';
import 'package:real_estate_app/features/messaging/domain/usecases/send_message.dart';
import 'package:real_estate_app/features/messaging/presentation/bloc/chat_bloc.dart';
import 'package:real_estate_app/features/property/data/datasources/property_remote_data_source_impl.dart';
import 'package:real_estate_app/features/property/domain/datasources/property_remote_data_source.dart';
import 'package:real_estate_app/features/property/data/repositories/property_repository_impl.dart';
import 'package:real_estate_app/features/property/domain/repositories/property_repository.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_featured_properties.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_filtered_properties.dart';
import 'package:real_estate_app/features/property/domain/usecases/get_search_properties.dart';
import 'package:real_estate_app/features/property/presentation/bloc/property_bloc.dart';
import 'package:real_estate_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:dio/dio.dart' as dio;

final getIt = GetIt.instance;
void initCoreFeature() {
  // Blocs
  getIt.registerFactory(() => PropertyBloc(
        getFeaturedProperties: getIt(),
        getFilteredProperties: getIt(),
      ));

  // Use cases
  getIt.registerLazySingleton(() => GetFilteredProperties(repository: getIt()));
  getIt.registerLazySingleton(() => GetFeaturedProperties(repository: getIt()));
  getIt.registerLazySingleton(() => GetSearchProperties(repository: getIt()));

  // Repository
  getIt.registerLazySingleton<PropertyRepository>(
    () => PropertyRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<PropertyRemoteDataSource>(
    () => PropertyRemoteDataSourceImpl(client: getIt<dio.Dio>()),
  );

  // External
  getIt.registerLazySingleton(() => dio.Dio());
  // routers
  getIt.registerLazySingleton(() => appRouter);
}

void initAuthenticationFeature() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton(() => LoginWithEmail(getIt()));
  getIt.registerLazySingleton(() => RegisterWithEmail(getIt()));
  getIt.registerLazySingleton(() => Logout(getIt()));
  // Authentication
  getIt.registerFactory(() => AuthBloc(
        loginWithEmail: getIt(),
        registerWithEmail: getIt(),
        logout: getIt(),
      ));
}

void initChatFeature() {
  // BLoC
  getIt.registerFactory(() => ChatBloc(
        getMessages: getIt(),
        sendMessage: getIt(),
      ));

  // Use cases
  getIt.registerLazySingleton(() => GetChatMessages(repository: getIt()));
  getIt.registerLazySingleton(() => SendMessage(repository: getIt()));

  // Repository
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(client: getIt<dio.Dio>()),
  );
}

initSearchFeature() {
  // Search
  getIt.registerFactory(() => SearchBloc(searchProperties: getIt()));
}

initFavoriteFeature() {
  // Favorites
  getIt.registerFactory(() => FavoritesBloc(
        getFavorites: getIt(),
        toggleFavorite: getIt(),
      ));
}

Future<void> init() async {
  initCoreFeature();
  initAuthenticationFeature();
  initSearchFeature();
  initFavoriteFeature();
  initChatFeature();
}
