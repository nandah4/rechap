import 'package:flutter/material.dart';

// Internal Package
import 'package:rechap/features/login/presentation/view_model/login_view_model.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/features/login/presentation/state/phone_country_state.dart';

// External Package
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryPickerWidget extends ConsumerWidget {
  final void Function(PhoneCountryData) onSelectCountry;
  const CountryPickerWidget({super.key, required this.onSelectCountry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);

    return GestureDetector(
      onTap: () => showCountryPicker(
        context: context,
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
          borderRadius: BorderRadius.circular(kRadius24),
          bottomSheetHeight: MediaQuery.of(context).size.height * 0.80,
          textStyle: kDescription(context),
          inputDecoration: InputDecoration(
            hintText: "Search country Phone ID",
            hintStyle: kDescription(context),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadius16),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadius16),
              borderSide: BorderSide(color: AppPallete.yellowSecondary),
            ),
          ),
        ),
        onSelect: (Country country) {
          onSelectCountry(
            PhoneCountryData(
              phoneCode: country.phoneCode,
              flagEmoji: country.flagEmoji,
            ),
          );
        },
      ),
      child: Text(
        "+ ${state.countryPhoneId.phoneCode} ${state.countryPhoneId.flagEmoji}",
        style: kDescription(context),
      ),
    );
  }
}
