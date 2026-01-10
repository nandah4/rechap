import 'package:flutter/material.dart';

/// Field types for profile edit modals
enum EditFieldType { name, bio }

/// Configuration for field edit modal
typedef Validator = String? Function(String value);

class EditFieldConfig {
  final String title;
  final String label;
  final String description;
  final String? hintText;
  final int? maxLength;
  final TextInputType type;
  final Validator validator;

  const EditFieldConfig({
    required this.title,
    required this.label,
    required this.description,
    this.maxLength,
    this.hintText,
    required this.type,
    required this.validator,
  });
}

/// Configuration map for each edit field type
final editFieldConfigs = <EditFieldType, EditFieldConfig>{
  EditFieldType.name: EditFieldConfig(
    title: "Edit Name",
    label: "Name",
    description: "Update the name displayed on your profile.",
    hintText: "Input Your Name",
    type: TextInputType.name,
    validator: (value) {
      if (value.isEmpty) return "Name is required";
      if (value.length < 2) return "Name must be at least 2 characters";
      return null;
    },
  ),
  EditFieldType.bio: EditFieldConfig(
    title: "Edit Bio",
    label: "Bio",
    description: "Bio will be displayed on your profile",
    hintText: "Write Your Favorite Things 😎",
    maxLength: 150,
    type: TextInputType.text,
    validator: (_) => null,
  ),
};
