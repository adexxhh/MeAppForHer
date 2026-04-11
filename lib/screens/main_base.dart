import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_dashboard_screen.dart';

class MainBase extends StatefulWidget {
  const MainBase({Key? key}) : super(key: key);

  @override
  State<MainBase> createState() => _MainBaseState();
}

class _MainBaseState extends State<MainBase> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeDashboardScreen(),
    const Center(child: Text('Trivia', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    const Center(child: Text('Music', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    const Center(child: Text('Life', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    const Center(child: Text('Draw', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          
          // Custom Bottom Navigation Bar
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
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
