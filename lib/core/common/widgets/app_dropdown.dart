import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';

class AppDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final void Function(T?) onChanged;
  final String? errorText;
  final ValueNotifier<T?> valueListanble = ValueNotifier(null);
  AppDropdown({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            isExpanded: true,
            valueListenable: valueListanble,
            hint: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                hint,
                style: AppTextStyles.font14Regular.copyWith(
                  color: context.customAppColors.grey500,
                ),
              ),
            ),
            items: items.map((item) {
              return DropdownItem<T>(
                value: item,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    labelBuilder(item),
                    style: AppTextStyles.font14Regular.copyWith(
                      color: context.customAppColors.grey500,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            buttonStyleData: ButtonStyleData(
              height: 55.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                color: context.customAppColors.grey50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: errorText != null
                      ? context.customAppColors.error500
                      : context.customAppColors.grey400,
                ),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(Icons.expand_more_rounded),
              iconSize: 26.sp,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: context.customAppColors.grey50,
                boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black12)],
              ),
            ),
            menuItemStyleData: MenuItemStyleData(padding: EdgeInsets.all(12.w)),
          ),
        ),

        if (errorText != null) ...[
          6.h.ph,
          Row(
            children: [
              Icon(
                Icons.error,
                color: context.customAppColors.error500,
                size: 18.sp,
              ),
              5.w.pw,
              Expanded(
                child: Text(
                  errorText!,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: context.customAppColors.error500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
