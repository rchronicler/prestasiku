import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'features/authentication/presentation/signup_screen.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'features/detail/presentation/detail_screen.dart';
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
      ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return Scaffold(
              backgroundColor: Color(0XFFF1F1F1),
              body: child,
              floatingActionButton: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  // show dialogs to add competition
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Add Competition'),
                            content: Text('Add competition form here'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // add competition to firestore
                                  Navigator.pop(context);
                                },
                                child: Text('Add'),
                              ),
                            ],
                          ));
                },
                child: const Icon(
                  Icons.add_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                backgroundColor: Color(0XFF165F23),
                // circle
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                color: Color(0XFF165F23),
                notchMargin: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    IconButton(
                      icon: Icon(Icons.home_outlined, color: Colors.white),
                      onPressed: () {
                        GoRouter.of(context).go('/home');
                      }
                    ),
                    IconButton(
                      icon: Icon(Icons.dashboard_outlined, color: Colors.white),
                      onPressed: null,
                    ),
                    // margin
                    SizedBox(width: 50),
                    IconButton(
                      icon: Icon(Icons.bookmark_outline, color: Colors.white),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month_outlined,
                          color: Colors.white),
                      onPressed: null,
                    )
                  ],
                ),
              ),
            );
          },
          routes: <RouteBase>[
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
            GoRoute(
                path: '/details/:docId',
                builder: (context, state) {
                  final docId = state.pathParameters['docId'];
                  return DetailScreen(docId: '$docId');
                }
            ),
          ]),
    ],
  );
}
