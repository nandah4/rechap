import 'package:flutter/material.dart';

// Internal Package
import 'package:rechap/data/model/auth_state.dart';
import 'package:rechap/data/providers/auth_providers.dart';
import 'package:rechap/ui/auth/widgets/country_picker_widget.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';
import 'package:rechap/ui/core/themes/app_typography.dart';
import 'package:rechap/ui/core/ui/button_primary_shared.dart';
import 'package:rechap/ui/core/ui/snackbar_shared.dart';

// External Package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Text controllers
    final phoneController = useTextEditingController();

    return Consumer(
      builder: (context, ref, _) {
        // Watchers and Notifiers
        final isLoadingState = ref.watch(isLoadingProvider);
        final notifier = ref.read(loginViewModelProvider.notifier);

        ref.listen(loginViewModelProvider, (previous, current) {
          if (current.status == LoginState.codeSent) {
            context.pushNamed(current.redirectPath);
          }

          if (current.status == LoginState.error) {
            SnackbarShared.error(context, current.errorMessage ?? '', 5);
          }
        });

        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: .all(kSpacing16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const SizedBox(height: kSpacing10),
                  Text("Let's get you signed up!", style: kTitleLogin(context)),
                  const SizedBox(height: kSpacing24),
                  Text(
                    "by signing up, you're agreeing to our Terms of Service and Privacy Policy. thanks!",
                    style: kSubTitleLogin(context),
                  ),
                  const SizedBox(height: kSpacing40),
                  Row(
                    children: [
                      CountryPickerWidget(
                        onSelectCountry: ref
                            .read(loginViewModelProvider.notifier)
                            .setSelectedCountryPhoneID,
                      ),
                      const SizedBox(width: kSpacing12),
                      Expanded(
                        child: SizedBox(
                          height: kButtonHeight56,
                          child: TextField(
                            controller: phoneController,
                            style: kDescription(context),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              hintStyle: kDescription(context),
                              labelStyle: kDescription(context),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(kRadius16),
                                borderSide: BorderSide(
                                  color: AppPallete.yellowSecondary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(kRadius16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: kSpacing24),
                  SizedBox(
                    height: kButtonHeight64,
                    width: double.infinity,
                    child: ButtonPrimaryShared(
                      isLoading: isLoadingState,
                      text: "Verifikasi OTP",
                      onPressed: () async {
                        notifier.verifyOTP(phoneController.text.trim());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
