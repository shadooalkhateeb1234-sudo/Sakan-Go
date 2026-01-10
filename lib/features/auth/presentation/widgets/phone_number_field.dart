import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberField extends StatefulWidget
{
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const PhoneNumberField({super.key, required this.controller, this.onChanged});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField>
{
  final FocusNode _focusNode = FocusNode();
  String? _error;

  void _validate(String value)
  {
    if (value.isEmpty)
    {
      _error = null;
    }
    else if (!value.startsWith('09'))
    {
      _error = 'Phone must start with 09';
    }
    else if (value.length != 10)
    {
      _error = 'Phone must be 10 digits';
    }
    else
    {
      _error = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(50);

    return TextField
    (
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      inputFormatters:
      [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration
      (
        helperText: ' ',
        errorText: _error,
        errorStyle: const TextStyle(height: 0.8),
        prefixIcon: const Icon(Icons.phone),
        labelText: 'Phone number',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder
        (
          borderRadius: borderRadius,
          borderSide: BorderSide(color: colors.outline)
        ),
        focusedBorder: OutlineInputBorder
        (
          borderRadius: borderRadius,
          borderSide: BorderSide(color: colors.primary, width: 2)
        ),
        errorBorder: OutlineInputBorder
        (
          borderRadius: borderRadius,
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder
        (
          borderRadius: borderRadius,
          borderSide: BorderSide(color: colors.error, width: 2)
        ),
      ),
      onChanged: (value)
      {
        _validate(value);
        widget.onChanged?.call(value);
      },
    );
  }
}