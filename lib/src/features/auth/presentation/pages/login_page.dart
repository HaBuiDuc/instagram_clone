import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/widgets/loading_page.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:instagram_clone/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:instagram_clone/src/features/auth/presentation/widgets/auth_button.dart';
import 'package:instagram_clone/src/features/auth/presentation/widgets/auth_field.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              context.read<AuthBloc>().add(AuthInitialEvent());
            }
            if (state is AuthSuccess) {
              context.read<AuthBloc>().add(AuthInitialEvent());
              Navigator.push(context, LoginPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingPage();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/insta_logo.png',
                  width: 182,
                  height: 49,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(
                    children: [
                      AuthField(
                        controller: emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AuthField(
                        controller: passwordController,
                        hintText: 'Password',
                        isObscured: true,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: ColorPalette.blueSky,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthButton(
                  onPressed: () {},
                  buttonText: 'Login',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/fb_logo.png',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Log in with Facebook',
                          style: TextStyle(
                            color: ColorPalette.blueSky,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 0.3,
                          color: ColorPalette.dimGray,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          'OR',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorPalette.dimGray,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 0.3,
                          color: ColorPalette.dimGray,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, SignUpPage.route());
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t  have an account? ',
                          style: TextStyle(color: ColorPalette.dimGray),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(color: ColorPalette.blueSky),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
