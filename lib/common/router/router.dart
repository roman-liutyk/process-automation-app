import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/auth/views/sign_in_view.dart';
import 'package:process_automation_app/features/auth/views/sign_up_view.dart';
import 'package:process_automation_app/features/home/views/home_view.dart';
import 'package:process_automation_app/features/project/views/project_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/sign_in',
  redirect: (context, state) async {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn = state.matchedLocation == '/sign_in';
    if (!loggedIn) return '/sign_in';
    if (loggingIn) return '/';
    // no need to redirect at all
    return null;
  },
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
        child: HomeView(),
      ),
    ),
    GoRoute(
      path: '/project/index',
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: ProjectView(),
        );
      },
    ),
  ],
);
