import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Hail Mary Background Generator extracted for global use
class HailMaryBackground extends StatelessWidget {
  const HailMaryBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random(42); // deterministic for stars
    return Stack(
      children: [
        // Base Deep Red/Black
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3B000B), Color(0xFF140004), Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        
        // Nebula Clusters
        Positioned(
          top: -100,
          right: -150,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0xFFB01D40).withOpacity(0.5), Colors.transparent],
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.1, 1.1), duration: 8.seconds),
        ),
        Positioned(
          bottom: 100,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0xFFE50940).withOpacity(0.3), Colors.transparent],
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.2, 1.2), duration: 10.seconds),
        ),
        Positioned(
          top: 200,
          left: 50,
          child: Container(
            width: 600,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0xFFFF3060).withOpacity(0.15), Colors.transparent],
              ),
            ),
          ),
        ),

        // Generate Tiny Stars
        ...List.generate(200, (index) {
          final top = random.nextDouble() * 1000;
          final left = random.nextDouble() * 500;
          final size = random.nextDouble() * 2.5 + 0.5;
          final opac = random.nextDouble() * 0.8 + 0.2;
          final isPinkish = random.nextBool();
          return Positioned(
            top: top,
            left: left,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: (isPinkish ? const Color(0xFFFFB3C6) : Colors.white).withOpacity(opac),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.white, blurRadius: size * 2)],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: opac, end: opac * 0.3, duration: (random.nextInt(2000) + 1000).ms),
          );
        }),
      ],
    );
  }
}
