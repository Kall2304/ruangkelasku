import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/copy/strings.dart';
import '../core/models/display_status.dart';
import '../core/theme/tokens.dart';
import '../features/auth/application/session.dart';
import '../features/auth/presentation/auth_forms.dart';
import '../features/auth/presentation/welcome_page.dart';
import '../features/courses/presentation/archived_page.dart';
import '../features/courses/presentation/class_shell.dart';
import '../features/courses/presentation/home_page.dart';
import '../features/courses/presentation/join_create_pages.dart';
import '../features/people/presentation/people_pages.dart';
import '../features/stream/presentation/announce_page.dart';
import '../features/stream/presentation/stream_page.dart';
import 'coming_soon_page.dart';

part 'router.g.dart';

const _publicPaths = {'/welcome', '/login', '/register'};

/// Rute mengikuti Peta Layar di docs/design.md.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final refresh = ValueNotifier(0);
  ref
    ..listen(sessionProvider, (_, _) => refresh.value++)
    ..onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final session = ref.read(sessionProvider);
      // Tunggu sesi diketahui; refreshListenable memicu redirect lagi setelahnya.
      if (!session.hasValue) return null;
      final loggedIn = session.value != null;
      final atPublic = _publicPaths.contains(state.matchedLocation);
      if (!loggedIn) return atPublic ? null : '/welcome';
      if (atPublic) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/welcome', builder: (_, _) => const WelcomePage()),
      GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, _) => const RegisterPage()),
      GoRoute(path: '/', builder: (_, _) => const HomePage()),
      GoRoute(path: '/join', builder: (_, _) => const JoinCoursePage()),
      GoRoute(path: '/courses/new', builder: (_, _) => const CreateCoursePage()),
      GoRoute(path: '/archived', builder: (_, _) => const ArchivedPage()),
      GoRoute(
        path: '/todo',
        builder: (_, _) => const ComingSoonPage(location: '/todo', title: S.navTodo),
      ),
      GoRoute(
        path: '/to-review',
        builder: (_, _) => const ComingSoonPage(location: '/to-review', title: S.navToReview),
      ),
      GoRoute(
        path: '/notifications',
        builder: (_, _) => const ComingSoonPage(location: '/notifications', title: S.navNotifications),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, _) => const ComingSoonPage(location: '/settings', title: S.navSettings),
      ),

      // Layar penuh di atas kelas (tanpa tab).
      GoRoute(
        path: '/c/:courseId/announce',
        builder: (_, state) => AnnouncePage(courseId: _courseId(state)),
      ),
      GoRoute(
        path: '/c/:courseId/people/invite',
        builder: (_, state) => InvitePage(
          courseId: _courseId(state),
          role: state.uri.queryParameters['role'] == 'teacher' ? CourseRole.teacher : CourseRole.student,
        ),
      ),
      GoRoute(path: '/c/:courseId', redirect: (_, state) => '/c/${state.pathParameters['courseId']}/stream'),

      // Empat tab kelas berbagi satu kerangka; perpindahan tab memakai fade through.
      ShellRoute(
        builder: (context, state, child) =>
            ClassShell(courseId: _courseId(state), location: state.matchedLocation, child: child),
        routes: [
          _tab('/c/:courseId/stream', (id) => StreamPage(courseId: id)),
          _tab('/c/:courseId/classwork', (_) => const ComingSoonBody()),
          _tab('/c/:courseId/people', (id) => PeoplePage(courseId: id)),
          _tab('/c/:courseId/grades', (_) => const ComingSoonBody()),
          _tab('/c/:courseId/my-work', (_) => const ComingSoonBody()),
        ],
      ),
    ],
  );
}

int _courseId(GoRouterState state) => int.parse(state.pathParameters['courseId']!);

GoRoute _tab(String path, Widget Function(int courseId) build) => GoRoute(
  path: path,
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: build(_courseId(state)),
    transitionDuration: Motion.medium,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (MediaQuery.disableAnimationsOf(context)) return child;
      return FadeThroughTransition(animation: animation, secondaryAnimation: secondaryAnimation, child: child);
    },
  ),
);
