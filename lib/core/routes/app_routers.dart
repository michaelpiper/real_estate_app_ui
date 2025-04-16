import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/core/presentation/layouts/main_layout.dart';
import 'package:real_estate_app/core/presentation/screens/not_found_screen.dart';
import 'package:real_estate_app/core/presentation/screens/splash_screen.dart';
// import 'package:real_estate_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:real_estate_app/features/property/presentation/pages/property_detail_page.dart';
import 'package:real_estate_app/features/property/presentation/pages/property_page.dart';
import 'package:real_estate_app/features/root/presentation/pages/root_page.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    // final authState = context.read<AuthBloc>().state;
    // final isLoggedIn = authState is AuthAuthenticated;

    // Routes that don't require authentication
    // const publicRoutes = ['/login', '/register', '/splash'];

    // // If user isn't logged in and trying to access private route
    // if (!isLoggedIn && !publicRoutes.contains(state.fullPath)) {
    //   return '/login';
    // }

    // If user is logged in but tries to access auth routes
    // if (isLoggedIn &&
    //     (state.fullPath == '/login' || state.fullPath == '/register')) {
    //   return '/';
    // }

    return null;
  },
  routes: [
    // Splash Screen
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // // Auth Routes
    // GoRoute(
    //   path: '/login',
    //   name: 'login',
    //   builder: (context, state) => const LoginScreen(),
    // ),
    // GoRoute(
    //   path: '/register',
    //   name: 'register',
    //   builder: (context, state) => const RegisterScreen(),
    // ),

    // Main App Shell (Protected Routes)
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const RootPage(),
          routes: [
            GoRoute(
              path: 'property/list',
              name: 'properties',
              builder: (context, state) {
                return const PropertyPage();
              },
            ),
            GoRoute(
              path: 'property/:id',
              name: 'property-details',
              builder: (context, state) {
                return const PropertyDetailPage();
              },
            ),
          ],
        ),
      ],
    ),

    // Not Found
    GoRoute(
      path: '/404',
      name: 'not-found',
      builder: (context, state) => const NotFoundScreen(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
