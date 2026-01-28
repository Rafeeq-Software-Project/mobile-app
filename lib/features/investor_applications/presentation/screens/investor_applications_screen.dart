import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../../../core/theme/app_texts/app_text_styles.dart';
import '../widgets/request_card.dart';
import '../widgets/stats_card.dart';

class InvestorApplicationsScreen extends StatelessWidget {
  const InvestorApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Investor Applications',
                style: AppTextStyles.font20SemiBold.copyWith(
                  color: colors.primary800,
                ),
              ),
            ),
            12.h.ph,
            Align(
              alignment: Alignment.center,
              child: Text(
                'Manage incoming partnership requests',
                style: AppTextStyles.font14Regular.copyWith(
                  color: colors.grey600,
                ),
              ),
            ),
            24.h.ph,
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    count: '12',
                    label: 'TOTAL APPLICANTS',
                    icon: Icons.people_outline,
                    iconColor: colors.primary500,
                    backgroundColor: colors.primary300.withValues(alpha: 0.1),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: StatsCard(
                    count: '5',
                    label: 'PENDING REVIEW',
                    icon: Icons.schedule,
                    iconColor: colors.grey600,
                    backgroundColor: colors.accent300.withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
            24.h.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Requests',
                  style: AppTextStyles.font18SemiBold.copyWith(
                    color: colors.grey900,
                  ),
                ),
                Text(
                  '3 New',
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: colors.primary800,
                  ),
                ),
              ],
            ),
            16.h.ph,
            RequestCard(
              name: 'Sarah Jenkins',
              role: 'Angel Investor',
              profileImage: 'https://i.pravatar.cc/150?img=1',
              isVerified: true,
              rating: 4.9,
              yearsActive: '6+ Years Exp',
              dealsCount: '12 Deals',
              tags: const ['SaaS', 'Artificial Intelligence', 'HealthTech'],
            ),
            16.h.ph,
            RequestCard(
              name: 'David Chen',
              role: 'VC Partner',
              profileImage: 'https://i.pravatar.cc/150?img=2',
              isVerified: false,
              rating: 4.7,
              yearsActive: '10+ Years Exp',
              dealsCount: '24 Deals',
              tags: const ['GreenTech', 'Sustainable Energy'],
            ),
            16.h.ph,
            RequestCard(
              name: 'Elena Rodriguez',
              role: 'Tech Lead & Investor',
              profileImage: 'https://i.pravatar.cc/150?img=3',
              isVerified: false,
              rating: 5.0,
              yearsActive: '4+ Years Exp',
              dealsCount: '4 Deals',
              tags: const ['Mobile Apps', 'Consumer'],
            ),
          ],
        ),
      ),
    );
  }
}
