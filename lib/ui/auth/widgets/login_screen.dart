import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerLoginViewModel = ref.watch(loginViewModelProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: .all(16),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(providerLoginViewModel.phoneNumber),
              TextField(
                controller: providerLoginViewModel.phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  providerLoginViewModel.verifyPhoneNumber();
                },
                child: Text("Verifikasi OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
