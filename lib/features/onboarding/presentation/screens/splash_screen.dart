import 'dart:math';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/core/utils/shared_pref_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      final isSeen = SharedPrefHelper.getBool(
        key: SharedPrefKeys.isOnBoardingSeen,
      );
      final isRegistered = SharedPrefHelper.getBool(
        key: SharedPrefKeys.isLoggedIn,
      );
      final role = SharedPrefHelper.getString(
        key: SharedPrefKeys.roleName,
      )?.toLowerCase();
      if (!mounted) return;
      if (isSeen == true && isRegistered != true) {
        GoRouter.of(context).pushReplacement(Routes.login);
      } else if (isRegistered == true) {
        if (role == "founder") {
          GoRouter.of(context).pushReplacement(Routes.navbarFounder);
        } else if (role == "investor") {
          GoRouter.of(context).pushReplacement(Routes.navbarInvestor);
        }
      } else {
        context.pushReplacement(Routes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildParticle() {
    final random = Random();
    return Positioned(
      top: random.nextDouble() * 800,
      left: random.nextDouble() * 400,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000 + random.nextInt(2000)),
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withValues(alpha: .6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B1C3D),
                  Color(0xFF1E3A8A),
                  Color(0xFF2563EB),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// ✨ Particles
          ...List.generate(20, (index) => buildParticle()),

          /// 💡 Logo + Animation
          Center(
            child: FadeTransition(
              opacity: opacityAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: .6),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Transform.rotate(
                    angle: _controller.value * 0.05,
                    child: Image.asset('assets/masters/logo.png', width: 180),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: opacityAnimation,
              child: const Center(
                child: Text(
                  "RAFEEQ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
