import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/blob_container.dart';

enum Vibe { normal, loveyDovey, divine, emotional, funny, inLove }

class HomeDashboardScreen extends StatefulWidget {
  final VoidCallback onVibeToggled;
  
  const HomeDashboardScreen({Key? key, required this.onVibeToggled}) : super(key: key);

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  Vibe _activeVibe = Vibe.normal;
  int _currentQuoteIndex = 0;
  bool _showCompliment = false;
  int _currentComplimentIndex = 0;
  
  Timer? _timer;
  Duration _timeDating = const Duration();

  List<String> _memes = [];
  bool _isLoadingMemes = false;

  final List<String> _emotionalQuotes = [
    "You are the most beautiful part of my life.",
    "Every day with you is a blessing.",
    "Your smile lights up my darkest days.",
    "I'm so incredibly proud of everything you do.",
    "You are my safe space, always.",
    "I swear I fall in love with you a little more every passing day.",
    "You're not just my girl, you're my best friend.",
    "When I look at you, my entire world makes sense.",
    "You make my heart flutter effortlessly.",
    "Your laugh is my absolute favorite sound on earth.",
    "Holding your hand feels like coming home.",
    "I admire your courage, your kindness, and your spectacular heart.",
    "You're the purest joy I've ever known.",
    "I love you vastly, unconditionally, and exclusively.",
    "You make ordinary moments feel like absolute magic."
  ];

  final List<String> _hugeCompliments = [
    "Khadija,\n\n"
    "Sometimes I just stop and realize how incredibly lucky I am. You are absolute perfection in my eyes. "
    "Every little thing about you—your smile, the way your eyes light up, your kindness, your humor—it all makes my "
    "heart skip a beat. You are the kind of precious soul that makes all the dark days disappear and makes the good days "
    "feel like a dream. You lift me up completely without even trying. You are stunning, brilliant, and breathtaking. "
    "Never forget that my world revolves around you. You are magic, my girl. Pure, beautiful magic.",

    "My sweet Khadija,\n\n"
    "The profound impact you've had on my life is impossible to measure. You have this extraordinary ability to "
    "make me feel like I can conquer the world just by being by my side. Your energy is infectious, and your heart "
    "is crafted from pure gold. There is a certain kind of warmth that only you bring into a room, a glow that makes "
    "everyone around you feel loved. You are my greatest inspiration, my most comforting thought, and the most magnificent "
    "woman I have ever known. I cherish every single fiber of your being.",

    "Khadija,\n\n"
    "I could spend a thousand lifetimes searching the universe and I would never find another soul as mesmerizing as yours. "
    "You are a masterpiece. The way you carry yourself, the depth of your thoughts, and the gentle way you care for others "
    "leaves me in absolute awe. Everyday I wake up, my first thought is how insanely blessed I am to call you mine. "
    "You are not just beautiful on the outside, but you possess a radiant, brilliant spirit that simply leaves me breathless. "
    "You are everything I could ever want and so much more."
  ];

  @override
  void initState() {
    super.initState();
    _startLiveTimer();
    _fetchMemes();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLiveTimer() {
    // Dating since Sept 4, 2025
    final startDate = DateTime(2025, 9, 4);
    _updateTime(startDate);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime(startDate);
    });
  }

  void _updateTime(DateTime start) {
    if (mounted) {
      setState(() {
        _timeDating = DateTime.now().difference(start);
      });
    }
  }

  Future<void> _fetchMemes({bool force = false}) async {
    if (!force && _memes.isNotEmpty) return; // already fetched
    setState(() {
      _isLoadingMemes = true;
      if (force) _memes.clear();
    });
    try {
      final response = await http.get(Uri.parse("https://meme-api.com/gimme/wholesomememes/5"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final memesData = data['memes'] as List;
        setState(() {
          _memes = memesData.map((m) => m['url'].toString()).toList();
        });
      }
    } catch (e) {
      debugPrint("Meme API error: $e");
    } finally {
      if (mounted) setState(() => _isLoadingMemes = false);
    }
  }

  void _onVibeClicked(Vibe vibe) {
    if (_activeVibe != vibe) {
      widget.onVibeToggled(); // Trigger nav bar bounce
    }
    
    setState(() {
      _activeVibe = vibe;
      _showCompliment = false; // exit compliment if entering a vibe 
      if (vibe == Vibe.emotional) {
        _currentQuoteIndex = Random().nextInt(_emotionalQuotes.length);
      } else if (vibe == Vibe.funny) {
        _fetchMemes();
      }
    });
  }

  void _toggleCompliment() {
    widget.onVibeToggled(); // Trigger nav bar bounce
    setState(() {
      _showCompliment = true;
      _activeVibe = Vibe.normal; // override vibe state
      _currentComplimentIndex = Random().nextInt(_hugeCompliments.length);
    });
  }

  void _goBackToDash() {
    widget.onVibeToggled(); // Trigger nav bar bounce
    setState(() {
      _activeVibe = Vibe.normal;
      _showCompliment = false;
    });
  }

  Color _getBackgroundColor() {
    if (_showCompliment) return AppTheme.pastelYellow.withOpacity(0.95);
    switch (_activeVibe) {
      case Vibe.loveyDovey:
        return AppTheme.bubblegumPink.withOpacity(0.4);
      case Vibe.divine:
        return AppTheme.pastelYellow.withOpacity(0.5);
      case Vibe.emotional:
        return AppTheme.bubblegumPink;
      case Vibe.funny:
        return AppTheme.starkWhite;
      default:
        return Colors.transparent;
    }
  }

  TextStyle _getHeaderStyle() {
    final baseStyle = const TextStyle(
      fontSize: 42,
      fontWeight: FontWeight.w900,
      color: AppTheme.starkBlack,
      height: 1.1,
    );
    
    if (_activeVibe == Vibe.divine && !_showCompliment) {
      return baseStyle.copyWith(
        color: AppTheme.pastelYellow,
        shadows: [
          const Shadow(
            color: AppTheme.starkBlack,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
          Shadow(
            color: Colors.orangeAccent.withOpacity(0.8),
            blurRadius: 20,
          )
        ],
      );
    }
    
    return baseStyle;
  }

  TextStyle _getSubHeaderStyle() {
    final baseStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppTheme.starkBlack,
    );

    if (_activeVibe == Vibe.divine && !_showCompliment) {
      return baseStyle.copyWith(
        color: AppTheme.starkBlack,
        shadows: [
          Shadow(
            color: Colors.yellowAccent.withOpacity(0.5),
            blurRadius: 10,
          )
        ],
      );
    }

    return baseStyle;
  }

  String _formatLiveTime() {
    if (_timeDating.inDays < 0) return "Starting soon! \u2728";
    final days = _timeDating.inDays;
    final hours = _timeDating.inHours % 24;
    final mins = _timeDating.inMinutes % 60;
    return "${days}d ${hours}h ${mins}m";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand( // Force it to fill the entire screen structure natively
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _getBackgroundColor(),
        child: Stack(
          children: [
            // --- MAIN BODY (HOME) ---
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Header
                    Text(
                      "hey khadija!\nwassup?",
                      style: _getHeaderStyle(),
                    ).animate(target: _activeVibe == Vibe.divine && !_showCompliment ? 1 : 0).shimmer(duration: 1000.ms),
                    const SizedBox(height: 8),
                    Text(
                      "have a fun time here XOXO",
                      style: _getSubHeaderStyle(),
                    ),
                    
                    const SizedBox(height: 30),

                    // What's the mood text
                    const Text(
                      "What's the mood?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.starkBlack,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Vibe Check Emojis
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: AppTheme.babyBlue,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                           BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
                        ]
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        children: [
                          _buildVibeEmoji("💖", Vibe.loveyDovey),
                          _buildVibeEmoji("✨", Vibe.divine),
                          _buildVibeEmoji("🥺", Vibe.emotional),
                          _buildVibeEmoji("😂", Vibe.funny),
                          _buildVibeEmoji("🥰", Vibe.inLove),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Overlapping Cards Section
                    SizedBox(
                      height: 320,
                      child: Stack(
                        children: [
                          // Background Card (Time Capsule)
                          Positioned(
                            top: 20,
                            left: 0,
                            right: 20,
                            child: BlobContainer(
                              color: AppTheme.sageGreen,
                              height: 220,
                              padding: const EdgeInsets.all(20),
                              customBorderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(90),
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
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.starkBlack,
                                        ),
                                      ),
                                      Icon(Icons.access_time_filled_rounded, color: AppTheme.starkBlack),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    _formatLiveTime(),
                                    style: const TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.starkWhite,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Since the magical day!",
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
                            bottom: 10,
                            right: 0,
                            child: GestureDetector(
                              onTap: _toggleCompliment,
                              child: Container(
                                width: 150,
                                height: 150,
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
                              ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 120), // Extra space for bottom nav
                  ],
                ),
              ),
            ),
            
            // --- OVERLAYS ---
            
            // Lovey Dovey Hearts Overlay
            if (_activeVibe == Vibe.loveyDovey)
              Positioned.fill(
                child: IgnorePointer(
                  child: Stack(
                    children: List.generate(15, (index) {
                      final random = Random();
                      return Positioned(
                        left: random.nextDouble() * MediaQuery.of(context).size.width,
                        top: MediaQuery.of(context).size.height, // start from bottom
                        child: const Icon(Icons.favorite, color: Colors.redAccent, size: 40)
                            .animate(onPlay: (controller) => controller.repeat())
                            .moveY(end: -1000, duration: (2000 + random.nextInt(2500)).ms)
                            .fadeOut(delay: 1500.ms)
                            .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.5, 1.5)),
                      );
                    }),
                  ),
                ),
              ),

            // Emotional Quotes Overlay
            if (_activeVibe == Vibe.emotional)
              Positioned(
                bottom: 150, // Sit just above the nav bar area but in front of cards
                left: 20,
                right: 20,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                         _currentQuoteIndex = Random().nextInt(_emotionalQuotes.length);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.starkWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26, 
                            blurRadius: 15, 
                            offset: Offset(0, 5)
                          )
                        ],
                        border: Border.all(color: AppTheme.starkBlack, width: 3),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _emotionalQuotes[_currentQuoteIndex],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.starkBlack,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "(tap for another)",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                    ).animate(key: ValueKey(_currentQuoteIndex)).slideY(begin: 0.3).fadeIn(),
                  ),
                ),
              ),

            // Funny Memes Overlay
            if (_activeVibe == Vibe.funny)
              Positioned.fill(
                child: Container(
                  color: AppTheme.starkWhite,
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Wholesome Memes! 😂", 
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.starkBlack)
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.refresh_rounded, size: 30, color: AppTheme.starkBlack),
                              onPressed: () => _fetchMemes(force: true), // Force refresh
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: _isLoadingMemes 
                            ? const Center(child: CircularProgressIndicator(color: AppTheme.starkBlack))
                            : PageView.builder(
                                controller: PageController(viewportFraction: 0.9),
                                itemCount: _memes.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppTheme.pastelYellow,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: AppTheme.starkBlack, width: 3),
                                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17), // slightly less than container to fit inside border
                                      child: InteractiveViewer( // Allows zooming on tap/pinch
                                        child: Image.network(
                                          _memes[index],
                                          fit: BoxFit.contain, // Prevent cropping!
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return const Center(child: CircularProgressIndicator(color: AppTheme.starkBlack));
                                          },
                                          errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error, color: Colors.red)),
                                        ),
                                      ),
                                    ),
                                  ).animate().scale(begin: const Offset(0.8, 0.8), delay: (index * 100).ms).fadeIn();
                                },
                              ),
                        ),
                        const SizedBox(height: 100), // padding for global nav
                      ],
                    ),
                  ),
                ).animate().slideY(begin: 1.0, curve: Curves.easeOutCirc),
              ),

            // In Love Magical Overlay
            if (_activeVibe == Vibe.inLove)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    color: AppTheme.starkBlack.withOpacity(0.85),
                    child: Center(
                      child: const Text(
                        "Adesh loves you more ✨",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.starkWhite,
                        ),
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                       .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 2.seconds)
                       .shimmer(duration: 2.seconds, color: AppTheme.bubblegumPink),
                    ),
                  ).animate().fadeIn(duration: 800.ms),
                ),
              ),

            // Emergency Compliment Overlay
            if (_showCompliment)
              Positioned.fill(
                child: Container(
                  color: AppTheme.starkBlack.withOpacity(0.95), // dark elegant background
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_awesome, color: AppTheme.pastelYellow, size: 60)
                            .animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.2,1.2), duration: 1.seconds),
                          const SizedBox(height: 40),
                          Text(
                            _hugeCompliments[_currentComplimentIndex],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 18,
                              height: 1.6,
                              color: AppTheme.starkWhite,
                              fontWeight: FontWeight.w500,
                            ),
                          ).animate(key: ValueKey(_currentComplimentIndex)).fadeIn(duration: 800.ms).slideY(begin: 0.2),
                          const SizedBox(height: 80), // nav bar clearance
                        ],
                      ),
                    ),
                  ),
                ).animate().slideY(begin: -1.0, curve: Curves.easeOutExpo), // drops down smooth
              ),

             // Universal Back / Reset Button for overlays
            if (_activeVibe != Vibe.normal || _showCompliment)
              Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                right: 20,
                child: GestureDetector(
                  onTap: _goBackToDash,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.starkBlack,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppTheme.starkWhite, width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(2,2), blurRadius: 4)],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.close_rounded, color: AppTheme.starkWhite, size: 20),
                        SizedBox(width: 8),
                        Text("Reset", style: TextStyle(color: AppTheme.starkWhite, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ).animate().scale(curve: Curves.elasticOut, duration: 600.ms),
              ),

          ],
        ),
      ),
    );
  }

  Widget _buildVibeEmoji(String emoji, Vibe targetVibe) {
    final isSelected = _activeVibe == targetVibe;
    return GestureDetector(
      onTap: () => _onVibeClicked(targetVibe),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.pastelYellow : AppTheme.starkWhite,
            shape: BoxShape.circle,
            border: isSelected ? Border.all(color: AppTheme.starkBlack, width: 2) : null,
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
