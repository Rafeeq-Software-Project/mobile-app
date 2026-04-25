import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/chatbot/data/models/chatbot_message_model.dart';
import 'package:rafeeq_app/features/chatbot/presentation/logic/chatbot/chatbot_cubit.dart';
import 'package:rafeeq_app/features/chatbot/presentation/logic/chatbot/chatbot_state.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ChatbotCubit>(),
      child: const _ChatbotView(),
    );
  }
}

class _ChatbotView extends StatefulWidget {
  const _ChatbotView();

  @override
  State<_ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<_ChatbotView>
    with TickerProviderStateMixin {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _pulseController;
  late AnimationController _bgController;
  bool _showScrollDown = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _scrollController.addListener(() {
      final atBottom =
          _scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 80;
      if (_showScrollDown == atBottom) {
        setState(() => _showScrollDown = !atBottom);
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _pulseController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        if (animated) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 100,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
          );
        } else {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent + 100,
          );
        }
      }
    });
  }

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    context.read<ChatbotCubit>().sendMessage(text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey50,
      body: Stack(
        children: [
          _AnimatedBackground(controller: _bgController),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context, colors),
                Expanded(
                  child: BlocConsumer<ChatbotCubit, ChatbotState>(
                    listener: (context, state) {
                      if (state.messages.isNotEmpty) _scrollToBottom();
                    },
                    builder: (context, state) {
                      return Stack(
                        children: [
                          _buildMessageList(state, colors),
                          if (_showScrollDown) _buildScrollDownButton(colors),
                        ],
                      );
                    },
                  ),
                ),
                _buildInputArea(context, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, colors) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          color: colors.grey0,
          boxShadow: [
            BoxShadow(
              color: colors.primary800.withValues(alpha: .08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border(
            bottom: BorderSide(color: colors.primary300.withValues(alpha: .4)),
          ),
        ),
        child: Row(
          children: [
            // Back
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.customAppColors.grey50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colors.primary800.withValues(alpha: .15),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colors.primary900,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Avatar with pulse ring
            AnimatedBuilder(
              animation: _pulseController,
              builder: (_, child) => Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary800.withValues(
                        alpha: 0.08 * _pulseController.value,
                      ),
                    ),
                  ),
                  child!,
                ],
              ),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [colors.primary900, colors.primary800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary800.withValues(alpha: .35),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.smart_toy_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Name + status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rafeeq AI',
                    style: TextStyle(
                      color: colors.primary900,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (_, __) => Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF22C55E),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF22C55E).withValues(
                                  alpha: 0.4 + 0.4 * _pulseController.value,
                                ),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Online now",
                        style: TextStyle(
                          color: colors.grey500,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Clear chat
            BlocBuilder<ChatbotCubit, ChatbotState>(
              builder: (ctx, state) {
                if (state.messages.length <= 1) return const SizedBox();
                return GestureDetector(
                  onTap: () => ctx.read<ChatbotCubit>().clearChat(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colors.grey50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.grey200),
                    ),
                    child: Icon(
                      Icons.refresh_rounded,
                      color: colors.grey600,
                      size: 18,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Message List ─────────────────────────────────────────────────────────────

  Widget _buildMessageList(ChatbotState state, colors) {
    final allMessages = [
      ...state.messages,
      if (state.isTyping)
        ChatMessage(
          text: '',
          role: MessageRole.bot,
          timestamp: DateTime.now(),
          isLoading: true,
        ),
    ];

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      itemCount: allMessages.length,
      itemBuilder: (context, index) {
        final msg = allMessages[index];
        final isUser = msg.role == MessageRole.user;
        final showAvatar =
            !isUser &&
            (index == 0 || allMessages[index - 1].role == MessageRole.user);

        return FadeInUp(
          duration: const Duration(milliseconds: 300),
          child: _MessageBubble(
            message: msg,
            isUser: isUser,
            showAvatar: showAvatar,
            colors: colors,
          ),
        );
      },
    );
  }

  // ── Scroll Down Button ───────────────────────────────────────────────────────

  Widget _buildScrollDownButton(colors) {
    return Positioned(
      bottom: 12,
      right: 16,
      child: FadeInUp(
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: _scrollToBottom,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.grey0,
              border: Border.all(
                color: colors.primary800.withValues(alpha: .2),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.primary800.withValues(alpha: .15),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colors.primary800,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  // ── Input Area ───────────────────────────────────────────────────────────────

  Widget _buildInputArea(BuildContext context, colors) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: colors.grey0,
          boxShadow: [
            BoxShadow(
              color: colors.primary800.withValues(alpha: .06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
          border: Border(top: BorderSide(color: colors.grey200)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colors.grey50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colors.primary800.withValues(alpha: .15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary800.withValues(alpha: .04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _inputController,
                  style: TextStyle(
                    color: colors.grey900,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 4,
                  minLines: 1,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: TextStyle(color: colors.grey400, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Send button
            BlocBuilder<ChatbotCubit, ChatbotState>(
              builder: (context, state) {
                final isBusy = state.isTyping;
                return AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, child) => Transform.scale(
                    scale: isBusy ? 0.92 + 0.08 * _pulseController.value : 1.0,
                    child: child,
                  ),
                  child: GestureDetector(
                    onTap: isBusy ? null : _sendMessage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isBusy
                            ? LinearGradient(
                                colors: [colors.grey200, colors.grey100],
                              )
                            : LinearGradient(
                                colors: [colors.primary900, colors.primary800],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        boxShadow: isBusy
                            ? []
                            : [
                                BoxShadow(
                                  color: colors.primary800.withValues(
                                    alpha: .4,
                                  ),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                      ),
                      child: isBusy
                          ? _TypingDotsButton(color: colors.grey500)
                          : Icon(
                              Icons.send_rounded,
                              color: colors.grey0,
                              size: 20,
                            ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Animated Background ─────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  const _AnimatedBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => CustomPaint(
        painter: _BgPainter(controller.value, colors),
        size: Size.infinite,
      ),
    );
  }
}

class _BgPainter extends CustomPainter {
  final double t;
  final dynamic colors;
  _BgPainter(this.t, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    // Base fill — use grey50
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF5F8FF),
    );

    // Soft top orb — primary glow
    final o1x = size.width * 0.75 + math.sin(t * 2 * math.pi) * 20;
    final o1y = size.height * 0.08 + math.cos(t * 2 * math.pi) * 15;
    canvas.drawCircle(
      Offset(o1x, o1y),
      130,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF3b82f6).withValues(alpha: .12),
            const Color(0xFF3b82f6).withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(o1x, o1y), radius: 130)),
    );

    // Soft bottom orb — accent
    final o2x = size.width * 0.15 + math.cos(t * 2 * math.pi) * 18;
    final o2y = size.height * 0.85 + math.sin(t * 2 * math.pi) * 22;
    canvas.drawCircle(
      Offset(o2x, o2y),
      110,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF1E3A8A).withValues(alpha: .08),
            const Color(0xFF1E3A8A).withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(o2x, o2y), radius: 110)),
    );

    // Subtle dot grid
    final dotPaint = Paint()
      ..color = const Color(0xFF4A90E2).withValues(alpha: .06);
    const spacing = 28.0;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_BgPainter old) => old.t != t;
}

// ─── Message Bubble ───────────────────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isUser;
  final bool showAvatar;
  final dynamic colors;

  const _MessageBubble({
    required this.message,
    required this.isUser,
    required this.showAvatar,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Bot avatar
          if (!isUser) ...[
            AnimatedOpacity(
              opacity: showAvatar ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [colors.primary900, colors.primary800],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary800.withValues(alpha: .25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.smart_toy_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          // Bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? LinearGradient(
                        colors: [colors.primary900, colors.primary800],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isUser ? null : colors.grey0,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                border: isUser
                    ? null
                    : Border.all(
                        color: colors.primary800.withValues(alpha: .1),
                      ),
                boxShadow: [
                  BoxShadow(
                    color: isUser
                        ? colors.primary800.withValues(alpha: .25)
                        : colors.grey300.withValues(alpha: .5),
                    blurRadius: isUser ? 14 : 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: message.isLoading
                  ? _TypingDots(color: colors.primary800)
                  : Text(
                      message.text,
                      style: TextStyle(
                        color: isUser ? colors.grey0 : colors.grey900,
                        fontSize: 14,
                        height: 1.55,
                      ),
                    ),
            ),
          ),

          // User avatar
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primary300.withValues(alpha: .4),
                border: Border.all(
                  color: colors.primary800.withValues(alpha: .2),
                ),
              ),
              child: Icon(
                Icons.person_rounded,
                color: colors.primary900,
                size: 17,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Typing Dots ─────────────────────────────────────────────────────────────

class _TypingDots extends StatefulWidget {
  final Color color;
  const _TypingDots({required this.color});

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final val = math
                .sin((_ctrl.value - i * 0.33) * math.pi)
                .clamp(0.0, 1.0);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.5),
              child: Transform.translate(
                offset: Offset(0, -5 * val),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withValues(alpha: 0.35 + 0.65 * val),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _TypingDotsButton extends StatefulWidget {
  final Color color;
  const _TypingDotsButton({required this.color});

  @override
  State<_TypingDotsButton> createState() => _TypingDotsButtonState();
}

class _TypingDotsButtonState extends State<_TypingDotsButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          final val = math
              .sin((_ctrl.value - i * 0.33) * math.pi)
              .clamp(0.0, 1.0);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.5),
            child: Transform.translate(
              offset: Offset(0, -3 * val),
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.4 + 0.6 * val),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
