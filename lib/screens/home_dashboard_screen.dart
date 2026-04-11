import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/blob_container.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // Header
          const Text(
            "Discover,\nCreate, Enjoy",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: AppTheme.starkBlack,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Work hard, play hard",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.starkBlack,
            ),
          ),
          
          const SizedBox(height: 30),

          // Vibe Check Emojis
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.babyBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildVibeEmoji("💖"),
                _buildVibeEmoji("✨"),
                _buildVibeEmoji("🥺"),
                _buildVibeEmoji("😂"),
                _buildVibeEmoji("🥰"),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Overlapping Cards Section
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                // Background Card (Time Capsule)
                Positioned(
                  top: 20,
                  left: 0,
                  right: 20,
                  child: BlobContainer(
                    color: AppTheme.sageGreen,
                    height: 200,
                    padding: const EdgeInsets.all(20),
                    customBorderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(80),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Time-Capsule",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.starkBlack,
                              ),
                            ),
                            Icon(Icons.lock_clock, color: AppTheme.starkBlack),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "03 Days : 12 Hrs",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.starkWhite,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Until our anniversary surprise!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.starkBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Emergency Compliment Starburst Button
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Show compliment
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("You are literally the cutest person alive! ✨"),
                          backgroundColor: AppTheme.starkBlack,
                        )
                      );
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        color: AppTheme.pastelYellow,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.starkBlack,
                            offset: Offset(4, 4),
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Emergency\nCompliment",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.starkBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 80), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildVibeEmoji(String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppTheme.starkWhite,
          shape: BoxShape.circle,
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
