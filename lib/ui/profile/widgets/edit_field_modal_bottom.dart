import 'package:flutter/material.dart';
import 'package:rechap/ui/core/themes/app_dimens.dart';
import 'package:rechap/ui/core/themes/app_palette.dart';
import 'package:rechap/ui/core/themes/app_typography.dart';
import 'package:rechap/ui/core/ui/button_primary_shared.dart';
import 'package:rechap/ui/profile/form/edit_field_type.dart';

class EditFieldModalBottom extends StatefulWidget {
  final EditFieldType fieldType;
  final String? initialValue;

  const EditFieldModalBottom({
    super.key,
    required this.fieldType,
    this.initialValue,
  });

  @override
  createState() => _EditFieldModalBottom();
}

class _EditFieldModalBottom extends State<EditFieldModalBottom> {
  late final TextEditingController _controller;
  String? _errorField;

  EditModalBottomSingle get config =>
      editModalBottomSingleConfig[widget.fieldType]!;

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
    final isValueValid = config.validator(value);

    if (isValueValid != null) {
      setState(() {
        _errorField = isValueValid;
      });
      return;
    }

    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: .only(
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
              textAlign: .center,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
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
