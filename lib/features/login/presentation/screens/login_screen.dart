import 'package:flutter/material.dart';

// Internal Package
import 'package:rechap/features/login/presentation/view_model/login_view_model.dart';
import 'package:rechap/features/login/presentation/state/login_state.dart';
import 'package:rechap/features/login/presentation/widgets/country_picker_widget.dart';

import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/ui/button_primary_shared.dart';
import 'package:rechap/core/ui/snackbar_shared.dart';

// External Package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {

        // Watchers and Notifiers
        final state = ref.watch(loginViewModelProvider);
        final notifier = ref.read(loginViewModelProvider.notifier);


        ref.listen(loginViewModelProvider, (previous, current) {
          if (current.status == LoginPhase.codeSent) {
            context.pushNamed(current.redirectPath);
          }

          if (current.status == LoginPhase.error) {
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
                            controller: _phoneController,
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
                      isLoading: state.status == LoginPhase.loading,
                      text: "Verifikasi OTP",
                      onPressed: () async {
                        notifier.sendOTP(_phoneController.text.trim());
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
