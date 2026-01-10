import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool readOnly;
  final VoidCallback? onTap;

  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double borderWidth;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.readOnly = false,
    this.onTap,
    required this.topLeftRadius,
    required this.topRightRadius,
    required this.bottomLeftRadius,
    required this.bottomRightRadius,
    this.borderWidth = 2.0,
    this.enabledBorderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
  });

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {}); // تحديث الحواف عند التركيز أو فقده
    });
    widget.controller.addListener(() {
      setState(() {}); // تحديث الحواف إذا تغير النص
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocusedOrFilled =
        _focusNode.hasFocus || widget.controller.text.isNotEmpty;

    OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(widget.topLeftRadius),
        topRight: Radius.circular(widget.topRightRadius),
        bottomLeft: Radius.circular(widget.bottomLeftRadius),
        bottomRight: Radius.circular(widget.bottomRightRadius),
      ),
      borderSide: BorderSide(color: color, width: widget.borderWidth),
    );

    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        enabledBorder: _buildBorder(widget.enabledBorderColor),
        focusedBorder:
        _buildBorder(isFocusedOrFilled ? widget.focusedBorderColor : widget.enabledBorderColor),
        errorBorder: _buildBorder(widget.errorBorderColor),
        focusedErrorBorder: _buildBorder(widget.errorBorderColor),
      ),
    );
  }
}
