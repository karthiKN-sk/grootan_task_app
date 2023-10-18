// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../app/core/app_themes.dart';
import '../../app/core/size.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String hintText;
  final String fieldTitle;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final GestureTapCallback? onTap;
  final int? maxLength;
  final String? errorText;
  final String? labelText;
  final double? borderRadius;
  final double? hintfontsize;
  final Color? bordercolor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final BorderSide? borderSide;
  final bool readOnly;
  final bool? enabled;
  final bool autofocus;
  final bool? isDense;
  final bool? isCollapsed;
  final AutovalidateMode? autovalidateMode;
  final ThemeData themeData;
  const CustomTextFormFeild({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    this.maxLength,
    this.errorText,
    this.onTap,
    this.fillColor,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.readOnly = false,
    this.borderRadius,
    this.bordercolor,
    this.hintfontsize,
    this.borderSide,
    this.contentPadding,
    this.isDense,
    this.isCollapsed,
    this.enabled,
    required this.themeData,
    required this.fieldTitle,
    this.labelText,
    this.autofocus = false,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: AppTheme.getTextStyle(
            themeData.textTheme.headlineSmall!,
            fontSize: AppSize.s18,
            color: themeData.colorScheme.primary,
            fontWeight: 600,
          ),
        ),
        verticalSpace(AppSize.s6),
        TextFormField(
          style: AppTheme.getTextStyle(
            themeData.textTheme.displayLarge!,
            fontSize: AppSize.s18!,
            color: themeData.colorScheme.background,
            fontWeight: 700,
          ),
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          autofocus: autofocus,
          onTap: onTap,
          maxLength: maxLength,
          controller: controller,
          inputFormatters: const [],
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.getTextStyle(
              themeData.textTheme.displayLarge!,
              fontSize: AppSize.s16!,
              color: themeData.colorScheme.background,
              fontWeight: 300,
            ),
            labelText: labelText,
            labelStyle: AppTheme.getTextStyle(
              themeData.textTheme.displayLarge!,
              fontSize: AppSize.s16!,
              color: themeData.colorScheme.primary,
              fontWeight: 300,
            ),
            counterText: "",
            filled: true,
            fillColor: themeData.colorScheme.primary.withOpacity(0.4),
            errorText: errorText,
            isDense: isDense,
            isCollapsed: isCollapsed ?? false,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    vertical: AppSize.s10!, horizontal: AppSize.s10!),
            enabledBorder: OutlineInputBorder(
              borderSide: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s10!),
            ),
            border: OutlineInputBorder(
              borderSide: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s10!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s10!),
            ),
          ),
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}
