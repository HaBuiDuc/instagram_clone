import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/app.dart';
import 'package:instagram_clone/src/features/add_post/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:instagram_clone/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:instagram_clone/src/features/search/presentation/blocs/search_user_bloc/search_user_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:instagram_clone/src/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserBloc>()),
        BlocProvider(
          create: (_) => serviceLocator<PostsBloc>(),
        ),
        BlocProvider(create: (_) => serviceLocator<PostBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserPostsBloc>()),
        BlocProvider(create: (_) => serviceLocator<SearchUserBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserProfileBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
