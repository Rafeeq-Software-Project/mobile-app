import 'package:lottie/lottie.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';

class CustomNotFound extends StatelessWidget {
  const CustomNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.h.ph,
        LottieBuilder.asset('assets/animations/not_found.json', height: 200.h),
        4.h.ph,
        Text(
          'No items found',
          style: AppTextStyles.font16Regular.copyWith(
            color: context.customAppColors.grey700,
          ),
        ),
      ],
    );
  }
}
