import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'features/authentication/presentation/signup_screen.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'features/home/presentation/home_screen.dart';
import 'package:prestasiku/src/features/authentication/presentation/signin_screen.dart';
import 'package:prestasiku/src/features/onboarding/presentation/onboarding_screen.dart';

import 'features/profile/presentation/profile_screen.dart';
import 'go_router_refresh_stream.dart';

part 'app_routers.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/onboarding',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final path = state.uri.path;
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (path.startsWith('/onboarding') || path.startsWith('/signin')) {
          return '/home';
        }
      } else {
        if (path.startsWith('/home')) {
          return '/onboarding';
        }
      }
      if (path == '/') {
        return '/onboarding';
      }
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const OnboardingScreen()),
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const SignInScreen()),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const SignUpScreen()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const HomeScreen()),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: ProfileScreen()),
      ),
    ],
  );
}
