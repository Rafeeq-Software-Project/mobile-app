import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_fonts.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class PopularQuestionsScreen extends StatefulWidget {
  const PopularQuestionsScreen({super.key});

  @override
  State<PopularQuestionsScreen> createState() => _PopularQuestionsScreenState();
}

class _PopularQuestionsScreenState extends State<PopularQuestionsScreen>
    with TickerProviderStateMixin {
  int? _expandedIndex;
  String _selectedCategory = 'all';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Map<String, dynamic>> get _categories => [
    {
      'key': 'all',
      'name': 'All',
      'icon': Icons.grid_view_rounded,
      'color': context.customAppColors.primary800,
    },
    {
      'key': 'general',
      'name': 'General',
      'icon': Icons.help_outline_rounded,
      'color': context.customAppColors.info700,
    },
    {
      'key': 'founders',
      'name': 'Founders',
      'icon': Icons.business_center_outlined,
      'color': context.customAppColors.primary500,
    },
    {
      'key': 'investments',
      'name': 'Investments',
      'icon': Icons.monetization_on_outlined,
      'color': context.customAppColors.accent700,
    },
    {
      'key': 'projects',
      'name': 'Projects',
      'icon': Icons.work_outline,
      'color': context.customAppColors.warning500,
    },
    {
      'key': 'account',
      'name': 'Account',
      'icon': Icons.account_circle_outlined,
      'color': context.customAppColors.error700,
    },
  ];

  List<Map<String, dynamic>> get _faqItems => [
    {
      'category': 'general',
      'question': 'What is Rafeeq for founders?',
      'answer':
          'Rafeeq is a platform that helps founders connect with investors and manage projects efficiently. It provides tools for collaboration and tracking.',
      'icon': Icons.info_outline_rounded,
      'color': context.customAppColors.primary800,
    },
    {
      'category': 'founders',
      'question': 'How can I register as a founder?',
      'answer':
          'You can register by completing your profile with accurate details, project ideas, and verification documents if needed.',
      'icon': Icons.person_add_alt_1_rounded,
      'color': context.customAppColors.info700,
    },
    {
      'category': 'investments',
      'question': 'How do I connect with investors?',
      'answer':
          'After posting your project, investors interested in your domain can contact you through the platform. You can manage all communications inside the app.',
      'icon': Icons.attach_money_rounded,
      'color': context.customAppColors.accent700,
    },
    {
      'category': 'projects',
      'question': 'Can I manage multiple projects?',
      'answer':
          'Yes, founders can create and manage multiple projects, track progress, and update investors about milestones.',
      'icon': Icons.work_outline,
      'color': context.customAppColors.warning500,
    },
    {
      'category': 'account',
      'question': 'How do I update my account info?',
      'answer':
          'Go to Settings > Account to update your personal information, contact details, and preferences.',
      'icon': Icons.account_circle_rounded,
      'color': context.customAppColors.error700,
    },
  ];

  List<Map<String, dynamic>> get _filteredFAQs {
    return _faqItems.where((faq) {
      final matchesCategory =
          _selectedCategory == 'all' || faq['category'] == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          faq['question'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          faq['answer'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.customAppColors.primary800;

    return Scaffold(
      backgroundColor: context.customAppColors.background,
      appBar: AppBar(
        backgroundColor: context.customAppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Popular Questions',
          style: AppTextStyles.font18Bold.copyWith(
            color: context.customAppColors.grey900,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            height: 1.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withValues(alpha: .1),
                  primaryColor.withValues(alpha: .3),
                  primaryColor.withValues(alpha: .1),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndCategories(),
          Expanded(
            child: _filteredFAQs.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20.w),
                    itemCount: _filteredFAQs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildFAQItem(
                          context: context,
                          index: index,
                          faq: _filteredFAQs[index],
                        ),
                      );
                    },
                  ),
          ),
          _buildSupportCard(),
        ],
      ),
    );
  }

  // دالة عرض الـ Search Bar والـ Categories
  Widget _buildSearchAndCategories() {
    final primaryColor = context.customAppColors.primary800;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.r, left: 20.r, right: 20.r),
          decoration: BoxDecoration(
            color: context.customAppColors.grey0,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.customAppColors.grey200),
          ),
          child: TextField(
            controller: _searchController,
            textAlign: TextAlign.right,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search questions...',
              hintStyle: const TextStyle(fontFamily: AppFonts.cairo),
              prefixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear_rounded, size: 20.sp),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              suffixIcon: Icon(Icons.search_rounded, color: primaryColor),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            reverse: true,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category['key'];
              final isFirstItem = index == 0;
              final isLastItem = index == _categories.length - 1;

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirstItem ? 20.w : 8.w,
                  right: isLastItem ? 20.w : 0,
                ),
                child: FilterChip(
                  selected: isSelected,
                  checkmarkColor: context.customAppColors.grey0,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        category['name'],
                        style: AppTextStyles.font12Regular.copyWith(
                          color: isSelected
                              ? context.customAppColors.grey0
                              : context.customAppColors.grey900,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        category['icon'],
                        size: 16.sp,
                        color: isSelected
                            ? context.customAppColors.grey0
                            : (category['color'] as Color),
                      ),
                    ],
                  ),
                  backgroundColor: context.customAppColors.grey0,
                  selectedColor: category['color'],
                  side: BorderSide(
                    color: isSelected
                        ? (category['color'] as Color)
                        : (context.customAppColors.grey200),
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category['key'];
                      _expandedIndex = null;
                    });
                  },
                  elevation: isSelected ? 4 : 0,
                  pressElevation: 2,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSupportCard() {
    final primaryColor = context.customAppColors.primary800;

    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need more help?',
                  style: AppTextStyles.font16SemiBold.copyWith(
                    color: context.customAppColors.grey0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Contact the support team',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: context.customAppColors.grey0.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.customAppColors.grey0,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_forward, color: primaryColor),
              onPressed: () {
                //! Navigate to support screen
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({
    required BuildContext context,
    required int index,
    required Map<String, dynamic> faq,
  }) {
    final isExpanded = _expandedIndex == index;
    final iconColor = faq['color'] as Color;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: context.customAppColors.grey0,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isExpanded
              ? iconColor.withValues(alpha: 0.5)
              : (context.customAppColors.grey200),
          width: isExpanded ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isExpanded
                ? iconColor.withValues(alpha: 0.15)
                : context.customAppColors.grey100,
            blurRadius: isExpanded ? 16 : 8,
            offset: Offset(0, isExpanded ? 6 : 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(18.w),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: iconColor.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(faq['icon'], color: iconColor, size: 22.sp),
                      ),

                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              faq['question'],
                              style: AppTextStyles.font16SemiBold.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: iconColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                faq['category'],
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: iconColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),

                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: isExpanded ? 0.5 : 0,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 24.sp,
                          color: iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1.h,
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                iconColor.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Text(
                          faq['answer'],
                          style: AppTextStyles.font14Regular.copyWith(
                            color: context.customAppColors.grey700,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80.sp,
            color: context.customAppColors.grey400,
          ),
          SizedBox(height: 16.h),
          Text(
            'لا توجد أسئلة',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: context.customAppColors.grey700,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'جرب تعديل البحث أو الفلتر',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.customAppColors.grey600,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
