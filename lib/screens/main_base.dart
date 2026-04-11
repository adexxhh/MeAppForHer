import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/hail_mary_background.dart';
import 'home_dashboard_screen.dart';
import 'trivia_screen.dart';
import 'makebelieve_screen.dart';
import 'draw_screen.dart';

class MainBase extends StatefulWidget {
  const MainBase({Key? key}) : super(key: key);

  @override
  State<MainBase> createState() => _MainBaseState();
}

class _MainBaseState extends State<MainBase> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _navController;
  late Animation<double> _navAnimation;

  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    // Animate from 30 (normal) down to -100 (hidden) and back to 30.
    _navAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 30.0, end: -100.0).chain(CurveTween(curve: Curves.easeIn)), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -100.0, end: 30.0).chain(CurveTween(curve: Curves.easeOutBack)), weight: 1),
    ]).animate(_navController);
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  void _triggerNavBarBounce() {
    _navController.forward(from: 0.0);
  }

  List<Widget> _buildPages() {
    return [
      HomeDashboardScreen(onVibeToggled: _triggerNavBarBounce),
      const TriviaScreen(),
      const Center(child: Text('Music', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      const MakebelieveScreen(),
      const DrawScreen(), // Repurposed from 'Draw' placeholder text
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Let background shine through
      extendBody: true,
      body: Stack(
        children: [
          const Positioned.fill(child: HailMaryBackground()), // GLOBAL BACKGROUND
          _buildPages()[_currentIndex],
          
          // Animated Custom Bottom Navigation Bar
          AnimatedBuilder(
            animation: _navAnimation,
            builder: (context, child) {
              return Positioned(
                left: 20,
                right: 20,
                bottom: _navAnimation.value,
                child: child!,
              );
            },
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppTheme.starkBlack,
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 10),
                    blurRadius: 20,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_rounded, 0),
                  _buildNavItem(Icons.extension_rounded, 1),
                  _buildNavItem(Icons.music_note_rounded, 2),
                  _buildNavItem(Icons.favorite_rounded, 3),
                  _buildNavItem(Icons.brush_rounded, 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: isSelected
            ? const BoxDecoration(
                color: AppTheme.starkWhite,
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          color: isSelected ? AppTheme.starkBlack : AppTheme.starkWhite,
          size: 28,
        ),
      ),
    );
  }
}
