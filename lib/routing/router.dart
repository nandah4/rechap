import 'package:go_router/go_router.dart';
import 'package:rechap/data/providers/firebase_providers.dart';
import 'package:rechap/routing/go_router_listenable.dart';
import 'package:rechap/ui/auth/widgets/login_screen.dart';
import 'package:rechap/ui/auth/widgets/verification_otp_screen.dart';
import 'package:rechap/ui/chat-list/widgets/chat_list_screen.dart';
import 'package:rechap/ui/onboard/widget/onboard_screen.dart';
import 'package:rechap/ui/profile/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _publicRoutes = <String>['/', '/auth/login', '/auth/otp'];

final router = Provider<GoRouter>((ref) {
  final authState = ref.read(firebaseAuthProvider);

  return GoRouter(
    refreshListenable: GoRouterListenable(authState.authStateChanges()),
    initialLocation: '/',
    redirect: (context, state) {
      final currUser = authState.currentUser != null;
      final currentPath = state.matchedLocation;
      final isGuestRoute = _publicRoutes.contains(currentPath);

      // If user is logged in but trying to access a public route -> redirect to chat-list
      if (currUser && isGuestRoute) {
        return '/chat-list';
      }

      if (!currUser && !isGuestRoute) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'onboard-screen',
        builder: (context, state) => OnboardScreen(),
      ),
      GoRoute(
        path: '/chat-list',
        name: 'chat-list-screen',
        builder: (context, state) => ChatListScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        name: 'login-screen',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/auth/otp',
        name: 'otp-screen',
        builder: (context, state) => VerificationOTPScreen(),
      ),

      GoRoute(
        path: '/profile',
        name: 'profile-screen',
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
});
