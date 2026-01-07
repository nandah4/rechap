import 'dart:async';

// Internal Packages
import 'package:rechap/data/providers/auth_providers.dart';
import 'package:rechap/ui/core/themes/app_typography.dart';

// Eksternal Packages
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownState {
  final int remainingSeconds;

  const CountdownState(this.remainingSeconds);

  bool get isFinished => remainingSeconds == 0;

  String get countdownFormatted {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

final countdownProvider = NotifierProvider<CountdownNotifier, CountdownState>(
  CountdownNotifier.new,
);

class CountdownNotifier extends Notifier<CountdownState> {
  Timer? _timer;

  @override
  CountdownState build() {
    ref.onDispose(() => _timer?.cancel());
    return const CountdownState(0);
  }

  void start(int seconds) {
    _timer?.cancel();

    state = CountdownState(seconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 1) {
        timer.cancel();
        state = const CountdownState(0);
      } else {
        state = CountdownState(state.remainingSeconds - 1);
      }
    });
  }

  void stop() {
    _timer?.cancel();
    state = const CountdownState(0);
  }
}

class OtpCountdown extends ConsumerStatefulWidget {
  const OtpCountdown({super.key});

  @override
  ConsumerState<OtpCountdown> createState() => _OtpCountdown();
}

class _OtpCountdown extends ConsumerState<OtpCountdown> {
  late final TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        ref.read(loginViewModelProvider.notifier).resendOTP();
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countdown = ref.watch(countdownProvider);

    if (countdown.isFinished) {
      return RichText(
        text: TextSpan(
          text: "didn't receive it? ",
          style: kDescription(
            context,
          ).copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          children: <TextSpan>[
            TextSpan(
              text: "tap to resend",
              style: kDescription(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
              recognizer: _tapGestureRecognizer,
            ),
          ],
        ),
      );
    }

    return Text(
      'Resend in ${countdown.countdownFormatted}',
      style: kDescription(context),
    );
  }
}
