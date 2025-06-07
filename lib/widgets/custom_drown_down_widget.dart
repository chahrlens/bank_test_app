import 'package:bank_test_app/data/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomDrownDownWidget<T> extends StatelessWidget {
  const CustomDrownDownWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.dropdownMenuEntries,
    required this.onSelected,
    this.selectedValue,
    this.validator,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final void Function(T?)? onSelected;
  final String? Function(T?)? validator;
  final T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        return SizedBox(
          width: double.infinity,
          child: FormField<T>(
            validator: validator,

            builder: (FormFieldState<T> state) {
              if (selectedValue != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  state.didChange(selectedValue);
                });
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 24.0 * 0.5),
                  Container(
                    color: AppColors.white,
                    child: DropdownMenu<T>(
                      width: width,
                      hintText: hintText,
                      controller: controller,
                      initialSelection: selectedValue,
                      dropdownMenuEntries: dropdownMenuEntries,
                      onSelected: (T? value) {
                        onSelected?.call(value);
                        state.didChange(value);
                      },
                    ),
                  ),
                  if (state.hasError) ...[
                    const SizedBox(height: 3),
                    Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 24.0),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
