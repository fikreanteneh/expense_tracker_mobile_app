import 'package:expense_tracker/application/auth/signup/signup_cubit.dart';
import 'package:expense_tracker/fetcher.dart';
import 'package:expense_tracker/signin.dart';
import 'package:expense_tracker/signup.dart';
import 'package:expense_tracker/utils.dart';
import 'package:go_router/go_router.dart';

final signUpBloc = SignupCubit(Fetcher());

GoRouter router = GoRouter(
  errorBuilder: ((context, state) => ErrorScreen(
        error: state.error,
      )),
  routes: [
    GoRoute(
      path: "/signin",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
