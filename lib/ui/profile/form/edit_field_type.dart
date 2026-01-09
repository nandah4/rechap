import 'package:flutter/material.dart';

enum EditFieldType { name, bio }

typedef Validator = String? Function(String value);

class EditModalBottomSingle {
  final String title;
  final String label;
  final String description;
  final String? hintText;
  final int? maxLength;
  final TextInputType type;
  final Validator validator;

  EditModalBottomSingle({
    required this.title,
    required this.label,
    required this.description,
    this.maxLength,
    this.hintText,
    required this.type,
    required this.validator,
  });
}

final editModalBottomSingleConfig = <EditFieldType, EditModalBottomSingle>{
  EditFieldType.name: EditModalBottomSingle(
    title: "Edit Name",
    label: "Name",
    description: "Update the name displayed on your profile.",
    hintText: "Input Your Name",
    type: TextInputType.name,
    validator: (value) {
      if (value.isEmpty) return "Name is required";
      return null;
    },
  ),
  EditFieldType.bio: EditModalBottomSingle(
    title: "Edit Bio",
    label: "Bio",
    description: "Bio will be displayed on you your profile",
    hintText: "Write Your Favorite Things 😎",
    maxLength: 150,
    type: TextInputType.text,
    validator: (_) => null,
  ),
};
