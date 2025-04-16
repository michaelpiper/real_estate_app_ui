import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/core/theme/text_styles.dart';
import 'package:real_estate_app/features/authentication/presentation/bloc/auth_bloc.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select<AuthBloc, bool>(
      (bloc) => bloc.state is AuthAuthenticated,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Image.asset(
              'assets/images/404.png',
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),

            // Title
            Text(
              'Page Not Found',
              style: TextStyles.headlineMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              "The page you're looking for doesn't exist or has been moved.",
              style: TextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Action Button
            FilledButton(
              onPressed: () {
                isAuthenticated ? context.go('/') : context.go('/login');
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isAuthenticated ? 'Go to Home' : 'Go to Login',
                style: TextStyles.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Optional: Contact Support
            if (isAuthenticated) ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.push('/support');
                },
                child: Text(
                  'Contact Support',
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
