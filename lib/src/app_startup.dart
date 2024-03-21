import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prestasiku/src/app_routers.dart';
import 'package:go_router/go_router.dart';
import 'package:prestasiku/src/features/onboarding/presentation/onboarding_screen.dart';


class AppStartup extends ConsumerWidget {
  const AppStartup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
