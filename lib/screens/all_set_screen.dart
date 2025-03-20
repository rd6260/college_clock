import 'package:flutter/material.dart';

class AllSetScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const AllSetScreen({super.key, required this.onComplete});

  @override
  State<AllSetScreen> createState() => _AllSetScreenState();
}

class _AllSetScreenState extends State<AllSetScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _checkmarkAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _subtextFadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Create animation controller with 1.5 second duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    // Staggered animations
    _checkmarkAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );
    
    _textFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
    );
    
    _subtextFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.9, curve: Curves.easeInOut),
    );
    
    // Start animation
    _controller.forward();
    
    // Trigger transition after 1.8 seconds
    Future.delayed(const Duration(milliseconds: 1800), () {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated checkmark
                  Transform.scale(
                    scale: _checkmarkAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Animated main text
                  Opacity(
                    opacity: _textFadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _textFadeAnimation.value)),
                      child: const Text(
                        "All Set!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Animated subtext
                  Opacity(
                    opacity: _subtextFadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _subtextFadeAnimation.value)),
                      child: const Text(
                        "Everything is ready. Let's get started!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}