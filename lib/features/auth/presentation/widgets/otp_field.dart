// import 'package:dartz/dartz.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// class OtpField extends StatefulWidget
// {
//   final TextEditingController controller;
//   final ValueChanged<String>? onChanged;
//
//   const OtpField({super.key,required this.controller,required this.onChanged});
//
//   @override
//   State<OtpField> createState() => _OtpFieldState();
// }
//
// class _OtpFieldState extends State<OtpField>
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return PinCodeTextField(
//       appContext: context,
//       length: 6,
//       controller: controller,
//       keyboardType: TextInputType.number,
//       animationType: AnimationType.scale,
//       enableActiveFill: false,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.circle,
//         fieldHeight: 50,
//         fieldWidth: 50,
//         activeColor: Theme.of(context).colorScheme.primary,
//         selectedColor:
//         Theme.of(context).colorScheme.primary,
//         inactiveColor: Colors.grey,
//       ),
//       onChanged:onChanged,
//     );
//   }
// }