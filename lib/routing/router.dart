import 'package:go_router/go_router.dart';
import 'package:rechap/ui/auth/widgets/login_screen.dart';
import 'package:rechap/ui/chat-list/widgets/chat_list_screen.dart';
import 'package:rechap/ui/onboard/widget/onboard_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => OnboardScreen()),
    GoRoute(path: '/auth/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/onboard', builder: (context, state) => OnboardScreen()),
  ],
);
