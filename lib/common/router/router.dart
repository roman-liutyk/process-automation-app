import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/auth/views/sign_in_view.dart';
import 'package:process_automation_app/features/auth/views/sign_up_view.dart';
import 'package:process_automation_app/features/project/views/project_list_view.dart';
import 'package:process_automation_app/features/task/views/task_board_view.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/sign_in',
  routes: [
    GoRoute(
      path: '/sign_in',
      redirect: (context, state) async {
        final User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return '/sign_in';
        }
        return '/';
      },
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignInView(),
      ),
    ),
    GoRoute(
      path: '/sign_up',
      redirect: (context, state) async {
        final User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return '/sign_up';
        }
        return '/';
      },
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignUpView(),
      ),
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: ProjectListView(),
      ),
      routes: [
        GoRoute(
          path: ':uuid/tasks',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TaskBoardView(),
          ),
        ),
      ],
    ),
  ],
);
