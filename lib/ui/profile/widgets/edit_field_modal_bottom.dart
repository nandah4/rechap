import 'package:flutter/material.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';
import 'package:rechap/ui/core/themes/app_typography.dart';
import 'package:rechap/ui/core/ui/button_primary_shared.dart';
import 'package:rechap/ui/profile/models/edit_field_config.dart';

class EditFieldModalBottom extends StatefulWidget {
  final EditFieldType fieldType;
  final String? initialValue;

  const EditFieldModalBottom({
    super.key,
    required this.fieldType,
    this.initialValue,
  });

  @override
  createState() => _EditFieldModalBottomState();
}

class _EditFieldModalBottomState extends State<EditFieldModalBottom> {
  late final TextEditingController _controller;
  String? _errorField;

  EditFieldConfig get config => editFieldConfigs[widget.fieldType]!;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String value) {
    final validationError = config.validator(value);

    if (validationError != null) {
      setState(() {
        _errorField = validationError;
      });
      return;
    }

    Navigator.pop(context, {widget.fieldType: value});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: kSpacing20,
        left: kSpacing16,
        right: kSpacing16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 26,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Text(
              config.title,
              style: kLabelProfile(context),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    config.label,
                    style: kFieldProfile(context),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: kSpacing10),
                  TextField(
                    controller: _controller,
                    autofocus: true,
                    maxLength: config.maxLength,
                    keyboardType: config.type,
                    decoration: InputDecoration(
                      errorText: _errorField,
                      errorStyle: kDescription(
                        context,
                      ).copyWith(color: AppPallete.error),
                      hintText: config.hintText,
                      hintStyle: kDescription(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadius16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadius16),
                        borderSide: BorderSide(
                          color: AppPallete.yellowSecondary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadius16),
                        borderSide: BorderSide(
                          color: AppPallete.error,
                          width: 2,
                        ),
                      ),
                    ),
                    style: kDescription(context),
                  ),
                  const SizedBox(height: kSpacing10),
                  Text(
                    config.description,
                    style: kDescription(context),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: kButtonHeight64,
              child: ButtonPrimaryShared(
                text: "Update",
                onPressed: () => _submit(_controller.text.trim()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
