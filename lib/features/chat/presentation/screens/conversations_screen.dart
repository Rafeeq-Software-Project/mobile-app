import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/conversation_list_item.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample conversations
  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'أستاذ أحمد',
      'lastMessage': 'أهلا، كيف حالك',
      'time': '10:00 م',
      'avatarUrl': 'assets/placeholder/test.jpg',
      'hasUnread': true,
    },
    {
      'name': 'أستاذ أحمد',
      'lastMessage': 'أهلا، كيف حالك',
      'time': '10:00 م',
      'avatarUrl': 'assets/placeholder/test.jpg',
      'hasUnread': false,
    },
    {
      'name': 'أستاذ أحمد',
      'lastMessage': 'أهلا، كيف حالك',
      'time': '10:00 م',
      'avatarUrl': 'assets/placeholder/test.jpg',
      'hasUnread': false,
    },
    {
      'name': 'أستاذ أحمد',
      'lastMessage': 'أهلا، كيف حالك',
      'time': '10:00 م',
      'avatarUrl': 'assets/placeholder/test.jpg',
      'hasUnread': false,
    },
    {
      'name': 'أستاذ أحمد',
      'lastMessage': 'أهلا، كيف حالك',
      'time': '10:00 م',
      'avatarUrl': 'assets/placeholder/test.jpg',
      'hasUnread': false,
    },
    {
      'name': 'أستاذ أحمد',
      'lastMessage': 'أهلا، كيف حالك',
      'time': '10:00 م',
      'avatarUrl': 'assets/placeholder/test.jpg',
      'hasUnread': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: CustomAppBar(
          title: 'المحادثات',
          subtitle: 'سيحفظ جميع محادثاتك هنا',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              24.h.ph,
              CustomSearchBar(
                controller: _searchController,
                hintText: 'ابحث من هنا',
                onChanged: (value) {
                  // Handle search
                },
              ),
              24.h.ph,
              Expanded(
                child: ListView.builder(
                  itemCount: _conversations.length,
                  itemBuilder: (context, index) {
                    final conversation = _conversations[index];
                    return ConversationListItem(
                      name: conversation['name'],
                      lastMessage: conversation['lastMessage'],
                      time: conversation['time'],
                      avatarUrl: conversation['avatarUrl'],
                      hasUnread: conversation['hasUnread'],
                      onTap: () {
                        GoRouter.of(context).push(Routes.chatScreen);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
