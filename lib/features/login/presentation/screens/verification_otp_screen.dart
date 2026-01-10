import 'package:flutter/material.dart';

// Internal Packages
import 'package:rechap/features/login/presentation/view_model/login_view_model.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/ui/snackbar_shared.dart';
import 'package:rechap/features/login/presentation/state/login_state.dart';
import 'package:rechap/features/login/presentation/widgets/countdown_resend_otp_widget.dart';

// Eksternal Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

class VerificationOTPScreen extends ConsumerWidget {
  const VerificationOTPScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(loginViewModelProvider.notifier);

    ref.listen(loginViewModelProvider, (previous, current) {
      if (current.status == LoginPhase.success) {
        context.goNamed(current.redirectPath);
      }

      if (current.status == LoginPhase.error) {
        SnackbarShared.error(context, current.errorMessage ?? '', 5);
      }
      if (previous?.status == LoginPhase.loading &&
          current.status == LoginPhase.codeSent) {
        SnackbarShared.success(context, 'We’ve sent your OTP code.', 5);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () => context.pop('auth/login'),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: kSpacing16),
          child: Column(
            children: [
              const SizedBox(height: kSpacing16),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    "Enter the code we just texted you",
                    style: kTitleLogin(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: kSpacing30),
              LayoutBuilder(
                builder: (ctx, constraint) {
                  final sizeRectangle = (constraint.maxWidth - 60) / 6;

                  return OtpTextField(
                    numberOfFields: 6,
                    fieldWidth: sizeRectangle,
                    fieldHeight: sizeRectangle,
                    borderRadius: .all(Radius.circular(kRadius8)),
                    borderColor: AppPallete.yellowSecondary,
                    cursorColor: AppPallete.yellowSecondary,
                    focusedBorderColor: AppPallete.yellowSecondary,
                    textStyle: kDescription(context),
                    showFieldAsBox: true,
                    onSubmit: (String verificationCode) {
                      notifier.submitOTPManually(verificationCode);
                    }, // end onSubmit
                  );
                },
              ),
              const SizedBox(height: kSpacing30),

              OtpCountdown(),
            ],
          ),
        ),
      ),
    );
  }
}
