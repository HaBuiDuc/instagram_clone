import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/theme/app_theme.dart';
import 'package:instagram_clone/src/features/add_post/presentation/pages/select_image.dart';
import 'package:instagram_clone/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:instagram_clone/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/post_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/pages/new_feeds.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/widgets/post.dart';
import 'package:instagram_clone/src/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram clone',
      theme: AppTheme.appTheme,
      home: const SelectImage(),
    );
  }
}
