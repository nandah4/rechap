import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rechap/core/routing/main_scaffold.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/di/firebase_providers.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/core/routing/go_router_listenable.dart';
import 'package:rechap/features/contacts/presentation/screens/contact_list_screen.dart';
import 'package:rechap/features/chat/presentation/screens/chat_screen.dart';
import 'package:rechap/features/login/presentation/screens/login_screen.dart';
import 'package:rechap/features/login/presentation/screens/verification_otp_screen.dart';
import 'package:rechap/features/chat-list/presentation/screens/chat_list_screen.dart';
import 'package:rechap/features/onboard/onboard_screen.dart';
import 'package:rechap/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _publicRoutes = <String>['/', '/auth/login', '/auth/otp'];

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final router = Provider<GoRouter>((ref) {
  final authState = ref.read(firebaseAuthProvider);

  return GoRouter(
    refreshListenable: GoRouterListenable(authState.authStateChanges()),
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
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
      // Protected Routes
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/chat-list',
            name: 'chat-list-screen',
            builder: (context, state) => ChatListScreen(),
            routes: <GoRoute>[
              GoRoute(
                path: 'chat/:conversationId',
                name: "chat",
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final conversationId =
                      state.pathParameters['conversationId']!;
                  return ChatScreen(conversationId: conversationId);
                },
              ),
            ],
          ),

          GoRoute(
            path: '/profile',
            name: 'profile-screen',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),

      // Public Routes
      GoRoute(
        path: '/',
        name: 'onboard-screen',
        builder: (context, state) => OnboardScreen(),
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
        path: '/contact-list',
        name: 'contact-list-screen',
        builder: (context, state) => Consumer(
          builder: (context, ref, child) => ContactListScreen(
            onContactSelected: (contact) async {
              final phoneNumber = contact.primaryPhoneNumber;
              if (phoneNumber == null || phoneNumber.isEmpty) return;

              final usecase = ref.read(createRoomChatUsecaseProvider);
              final result = await usecase(phoneNumber);

              if (result.success && result.data != null) {
                if (context.mounted) {
                  context.push('/chat-list/chat/${result.data!.id}');
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppPallete.error,
                      content: Text(result.message ?? 'Failed to create chat'),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    ],
  );
});
