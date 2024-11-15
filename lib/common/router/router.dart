import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/auth/views/sign_in_view.dart';
import 'package:process_automation_app/features/auth/views/sign_up_view.dart';
import 'package:process_automation_app/features/dashboard/views/dashboard_view.dart.dart';
import 'package:process_automation_app/features/home/home_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/sign_in',
  routes: [
    GoRoute(
      path: '/sign_in',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignInView(),
      ),
    ),
    GoRoute(
      path: '/sign_up',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignUpView(),
      ),
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: DashboardView(),
      ),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: HomeView(),
      ),
    ),
  ],
);
