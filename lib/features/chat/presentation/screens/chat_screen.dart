import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/chat/presentation/widgets/attachment_menu.dart';
import 'package:rafeeq_app/features/chat/presentation/widgets/chat_input_bar.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showAttachmentMenu = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'message':
          'لعلك قد تسأل السؤال عليك أن تسأل سؤالا قبل مدة هنا تعلق على سؤالك للحديث مرة اخرى',
      'time': '10:00 م',
      'isMyMessage': false,
    },
    {
      'message':
          'لعلك قد يسأل السؤال، السؤال عليك أن تسأل، سؤالا قبلها يعد هنا تعلق على سؤالك للحديث مرة اخرى',
      'time': '10:00 م',
      'isMyMessage': true,
    },
    {
      'message':
          'لعلك قد تسأل السؤال عليك أن تسأل سؤالا قبل مدة هنا تعلق على سؤالك للحديث مرة اخرى',
      'time': '10:00 م',
      'isMyMessage': false,
    },
    {
      'message':
          'لعلك قد يسأل السؤال، السؤال عليك أن تسأل، سؤالا قبلها يعد هنا تعلق على سؤالك للحديث مرة اخرى',
      'time': '10:00 م',
      'isMyMessage': true,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleAttachmentMenu() {
    setState(() {
      _showAttachmentMenu = !_showAttachmentMenu;
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: colors.primary800,
          leading: Center(
            child: Container(
              height: 24.h,
              width: 24.h,
              decoration: BoxDecoration(
                color: colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),

              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colors.primary500,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            ChatHeader(
              name: 'أستاذ أحمد',
              subtitle: 'نشط قبل ساعة واحدة',
              avatarUrl: 'assets/placeholder/test.jpg',
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.w),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatMessageBubble(
                    message: message['message'],
                    time: message['time'],
                    isMyMessage: message['isMyMessage'],
                  );
                },
              ),
            ),
            if (_showAttachmentMenu)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: AttachmentMenu(
                  onVideoTap: () {
                    _toggleAttachmentMenu();
                  },
                  onImageTap: () {
                    _toggleAttachmentMenu();
                  },
                  onDocumentTap: () {
                    _toggleAttachmentMenu();
                  },
                ),
              ),
            ChatInputBar(
              controller: _messageController,
              onSend: _sendMessage,
              onAttachment: _toggleAttachmentMenu,
              onVoice: () {
                // Handle voice message
              },
            ),
          ],
        ),
      ),
    );
  }
}
