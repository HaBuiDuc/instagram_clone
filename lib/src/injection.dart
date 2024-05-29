import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/src/features/newfeeds/data/data_sources/firebase_data_source.dart';
import 'package:instagram_clone/src/features/newfeeds/data/repositories/posts_repository_impl.dart';
import 'package:instagram_clone/src/features/newfeeds/data/repositories/user_repository_impl.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/posts_repository.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/user_repository.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/use_cases/get_user.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:instagram_clone/src/firebase_options.dart';
import 'package:instagram_clone/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:instagram_clone/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:instagram_clone/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:instagram_clone/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:instagram_clone/src/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:instagram_clone/src/features/auth/presentation/bloc/auth/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  // _initDb();
  _initNewFeeds();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void _initAuth() {
  serviceLocator
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl())
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()))
    ..registerFactory(() => SignUpUseCase(authRepository: serviceLocator()))
    ..registerFactory(() => LoginUseCase(authRepository: serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(serviceLocator(), serviceLocator()));
}

void _initDb() {
  final db = FirebaseFirestore.instance;
  serviceLocator.registerFactory(() => db);
}

void _initNewFeeds() {
  serviceLocator
    ..registerLazySingleton<FirebaseDataSource>(
        () => FirebaseDataSourceImpl())
    ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(firebaseDataSource: serviceLocator()))
    ..registerFactory<PostsRepository>(() => PostsRepositoryImpl())
    ..registerFactory(() => GetUser(userRepository: serviceLocator()))
    ..registerLazySingleton(() => UserBloc(serviceLocator()));
}
