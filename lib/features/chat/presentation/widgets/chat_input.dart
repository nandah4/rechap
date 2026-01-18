import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';

class ChatInput extends StatefulWidget {
  final ValueChanged<String> onTap;

  const ChatInput({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _ChatInput();
}

class _ChatInput extends State<ChatInput> {
  late final TextEditingController _textEditingController;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void submit(String message) {
    if (message.isEmpty) return;

    widget.onTap(message);
    _textEditingController.text = '';

    setState(() {
      _isEmpty = true;
    });
  }

  void _checkEmpty(String value) {
    if (value.isEmpty) {
      setState(() {
        _isEmpty = true;
      });
    } else {
      setState(() {
        _isEmpty = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(width: 1, color: AppPallete.greyBorder)),
      ),
      padding: EdgeInsets.only(
        left: kSpacing16,
        right: kSpacing16,
        top: kSpacing12,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              style: kDescription(context),
              onChanged: (value) => _checkEmpty(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius16),
                  borderSide: BorderSide(
                    color: AppPallete.greyText,
                    width: kSpacing2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius16),
                  borderSide: BorderSide(
                    color: AppPallete.greyText,
                    width: kSpacing2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: kSpacing16),
          GestureDetector(
            onTap: () =>
                _isEmpty ? null : submit(_textEditingController.text.trim()),
            child: Container(
              padding: EdgeInsets.all(kSpacing16),
              decoration: BoxDecoration(
                color: _isEmpty ? AppPallete.greyText : AppPallete.blackPrimary,
                borderRadius: BorderRadius.all(Radius.circular(kSpacing30)),
              ),
              child: Icon(
                FontAwesome.paper_plane,
                color: AppPallete.backgroundGrey,
                size: kFontSize20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
