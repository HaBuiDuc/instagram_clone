import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/src/core/common/data/firebase_data_source.dart';
import 'package:instagram_clone/src/core/common/services/user_services.dart';
import 'package:instagram_clone/src/core/common/use_case/get_current_user.dart';
import 'package:instagram_clone/src/features/add_post/data/data_sources/add_post_data_source.dart';
import 'package:instagram_clone/src/features/add_post/data/repositories/post_repository_impl.dart';
import 'package:instagram_clone/src/features/add_post/domain/repositories/post_repository.dart';
import 'package:instagram_clone/src/features/add_post/domain/use_cases/add_post.dart';
import 'package:instagram_clone/src/features/add_post/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/data/data_sources/newfeeds_data_source.dart';
import 'package:instagram_clone/src/features/newfeeds/data/repositories/posts_repository_impl.dart';
import 'package:instagram_clone/src/features/newfeeds/data/repositories/user_repository_impl.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/posts_repository.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/user_repository.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/use_cases/get_posts.dart';
import 'package:instagram_clone/src/core/common/use_case/get_user.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:instagram_clone/src/features/search/data/data_sources/search_data_source.dart';
import 'package:instagram_clone/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:instagram_clone/src/features/search/domain/repositories/search_repository.dart';
import 'package:instagram_clone/src/features/search/domain/use_cases/search_user.dart';
import 'package:instagram_clone/src/features/search/presentation/blocs/search_user_bloc/search_user_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/data/data_sources/user_profile_data_source.dart';
import 'package:instagram_clone/src/features/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:instagram_clone/src/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/add_following.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/check_following.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/get_user_posts.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/unfollow.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/updating_user_data.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/following_bloc/following_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:instagram_clone/src/firebase_options.dart';
import 'package:instagram_clone/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:instagram_clone/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:instagram_clone/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:instagram_clone/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:instagram_clone/src/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:instagram_clone/src/features/auth/presentation/bloc/auth/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initUserServices();
  _initAuth();
  _initNewFeeds();
  _initAddingPost();
  _initUserProfile();
  _initSearchUser();
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

void _initNewFeeds() {
  serviceLocator
    ..registerLazySingleton<NewfeedsDataSource>(
        () => NewfeedsDataSourceImpl(firebaseDataSource: serviceLocator()))
    ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(firebaseDataSource: serviceLocator()))
    ..registerFactory<PostsRepository>(
        () => PostsRepositoryImpl(firebaseDataSource: serviceLocator()))
    ..registerFactory(() => GetPosts(postRepository: serviceLocator()))
    ..registerLazySingleton(() => UserBloc(serviceLocator()))
    ..registerLazySingleton(() => PostsBloc(serviceLocator()));
}

void _initAddingPost() {
  serviceLocator
    ..registerLazySingleton<AddPostDataSource>(() => AddPostDataSourceImpl())
    ..registerFactory<PostRepository>(
        () => PostRepositoryImpl(firebaseDataSource: serviceLocator()))
    ..registerFactory(() => AddPost(postRepository: serviceLocator()))
    ..registerLazySingleton(() => PostBloc(serviceLocator()));
}

void _initUserProfile() {
  serviceLocator
    ..registerLazySingleton<UserProfileDataSource>(
        () => UserProfileDataSourceImpl())
    ..registerFactory<UserProfileRepository>(() =>
        UserProfileRepositoryImpl(userProfileDataSource: serviceLocator()))
    ..registerFactory(
        () => GetUserPosts(userProfileRepository: serviceLocator()))
    ..registerFactory(
        () => AddFollowing(userProfileDataSource: serviceLocator()))
    ..registerFactory(() => Unfollow(userProfileRepository: serviceLocator()))
    ..registerFactory(
        () => CheckFollowing(userProfileDataSource: serviceLocator()))
    ..registerFactory(
        () => UpdatingUserData(userProfileRepository: serviceLocator()))
    ..registerLazySingleton(() => UserPostsBloc(serviceLocator()))
    ..registerLazySingleton(() =>
        FollowingBloc(serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerLazySingleton(() =>
        UserProfileBloc(serviceLocator(), serviceLocator()));
}

void _initSearchUser() {
  serviceLocator
    ..registerLazySingleton<SearchDataSource>(() => SearchDataSourceImpl())
    ..registerFactory<SearchRepository>(
        () => SearchRepositoryImpl(searchDataSource: serviceLocator()))
    ..registerFactory(() => SearchUser(searchRepository: serviceLocator()))
    ..registerLazySingleton(() => SearchUserBloc(serviceLocator()));
}

void _initUserServices() {
  serviceLocator
    ..registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSourceImpl())
    ..registerFactory<UserServices>(
        () => UserServicesImpl(firebaseDataSource: serviceLocator()))
    ..registerFactory(() => GetUser(userServices: serviceLocator()))
    ..registerFactory(() => GetCurrentUser(userServices: serviceLocator()));
}
