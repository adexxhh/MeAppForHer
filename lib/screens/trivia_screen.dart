import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/trivia_data.dart';

enum TriviaState { categories, playing, result }

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({Key? key}) : super(key: key);

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  TriviaState _state = TriviaState.categories;
  String _activeCategory = "";
  List<TriviaQuestion> _questions = [];
  int _currentIdx = 0;
  int _hp = 0;
  int? _selectedOptionIdx;
  bool _showingAnswer = false;

  void _startCategory(String category) {
    setState(() {
      _activeCategory = category;
      _questions = TriviaData.getQuestionsForCategory(category);
      _currentIdx = 0;
      _hp = 0;
      _state = TriviaState.playing;
      _selectedOptionIdx = null;
      _showingAnswer = false;
    });
  }

  void _answerQuestion(int optionIdx) {
    if (_showingAnswer) return; // Prevent double pressing
    setState(() {
      _selectedOptionIdx = optionIdx;
      _showingAnswer = true;
      if (optionIdx == _questions[_currentIdx].correctIndex) {
        _hp += 1;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        if (_currentIdx < 4) {
          _currentIdx++;
          _selectedOptionIdx = null;
          _showingAnswer = false;
        } else {
          _state = TriviaState.result;
        }
      });
    });
  }

  Future<void> _claimWhatsAppPrize() async {
    const phoneNumber = "918102577588";
    final message = Uri.encodeComponent("see, this is how much i love you - now you owe me a gift for the full score! lessgooo beachh");
    
    final Uri whatsappAppUri = Uri.parse("whatsapp://send?phone=$phoneNumber&text=$message");
    final Uri fallbackWebUri = Uri.parse("https://api.whatsapp.com/send?phone=$phoneNumber&text=$message");

    try {
      // Force launch to bypass Android 11 package visibility limits without querying
      bool launched = await launchUrl(whatsappAppUri);
      if (!launched) {
        await launchUrl(fallbackWebUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      await launchUrl(fallbackWebUri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildCategories() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Trivia Time!",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: AppTheme.starkBlack),
          ).animate().slideY(begin: -0.5).fadeIn(),
          const SizedBox(height: 10),
          const Text(
            "Test your knowledge about us.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 50),
          
          _buildCategoryBtn("\uD83D\uDC76 \n The Adesh Lore", TriviaData.catLore, AppTheme.babyBlue, 400),
          _buildCategoryBtn("\uD83E\uDD13 \n The Nerd Files", TriviaData.catNerd, AppTheme.pastelYellow, 500),
          _buildCategoryBtn("\uD83D\uDC96 \n The Khadija Chapter", TriviaData.catUs, AppTheme.bubblegumPink, 600),
        ],
      ),
    );
  }

  Widget _buildCategoryBtn(String title, String category, Color color, int delayMs) {
    return GestureDetector(
      onTap: () => _startCategory(category),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.starkBlack, width: 3),
          boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 0)],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppTheme.starkBlack, height: 1.3),
        ),
      ).animate().scale(delay: delayMs.ms, curve: Curves.easeOutBack),
    );
  }

  Widget _buildPlaying() {
    final q = _questions[_currentIdx];
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: const Icon(Icons.arrow_back_ios, size: 24), onPressed: () => setState(() => _state = TriviaState.categories)),
            Text("HP: $_hp / 5", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppTheme.starkBlack))
                .animate(key: ValueKey(_hp)).shakeX(duration: 300.ms).scale(begin: const Offset(1,1), end: const Offset(1.3,1.3)),
          ],
        ),
        const SizedBox(height: 20),
        
        // Massive Emote Representation
        Container(
          height: 120,
          alignment: Alignment.center,
          child: Text(
            q.emote,
            style: const TextStyle(fontSize: 80),
          ).animate(key: ValueKey(q.question)).scale(curve: Curves.elasticOut, duration: 800.ms),
        ),
        
        const SizedBox(height: 20),
        
        // The Question Text
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.starkWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.starkBlack, width: 2),
            boxShadow: const [BoxShadow(offset: Offset(4, 4), color: Colors.black12)],
          ),
          child: Text(
            q.question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.starkBlack),
          ),
        ).animate(key: ValueKey("box_${q.question}")).slideX(begin: 1.0, curve: Curves.easeOutCirc),
        
        const SizedBox(height: 30),
        
        // Options List
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, idx) {
              final isSelected = _selectedOptionIdx == idx;
              final isCorrectOption = idx == q.correctIndex;
              
              Color btnColor = AppTheme.starkWhite;
              if (_showingAnswer) {
                if (isCorrectOption) {
                  btnColor = Colors.greenAccent.shade200; // Correct answer flashes green
                } else if (isSelected) {
                  btnColor = Colors.redAccent.shade200; // Wrong choice flashes red
                }
              } else if (isSelected) {
                btnColor = Colors.grey.shade300;
              }

              return GestureDetector(
                onTap: () => _answerQuestion(idx),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppTheme.starkBlack, width: 2),
                  ),
                  child: Text(
                    q.options[idx],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.starkBlack),
                  ),
                ).animate(key: ValueKey("btn_${q.question}_$idx")).scale(delay: (idx * 150).ms, curve: Curves.easeOutBack),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResult() {
    bool isPerfect = _hp == 5;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isPerfect ? "\uD83C\uDF89 WINNER! \uD83C\uDF89" : "Good Try!",
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: AppTheme.starkBlack),
          ).animate().scale(curve: Curves.elasticOut),
          const SizedBox(height: 20),
          Text(
            "You scored $_hp / 5 HP",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          if (isPerfect) ...[
            const Text(
              "You know me flawlessly...\nYou've unlocked the special prize!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.starkBlack),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _claimWhatsAppPrize,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // WhatsApp green!
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: const BorderSide(color: AppTheme.starkBlack, width: 3)),
                elevation: 10,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.message, size: 28),
                  SizedBox(width: 10),
                  Text("CLAIM YOUR GIFT \uD83C\uDF81", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 1.seconds),
          ] else ...[
            const Text(
              "Almost! You need a perfect 5/5 to unlock your WhatsApp gift. Try again!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.redAccent),
            ).animate().slideY(begin: 0.5),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => setState(() => _state = TriviaState.categories),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.starkBlack,
                foregroundColor: AppTheme.starkWhite,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Study & Replay \u21A9\uFE0F", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeContent;
    switch (_state) {
      case TriviaState.categories:
        activeContent = _buildCategories();
        break;
      case TriviaState.playing:
        activeContent = _buildPlaying();
        break;
      case TriviaState.result:
        activeContent = _buildResult();
        break;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
          child: KeyedSubtree(key: ValueKey(_state), child: activeContent),
        ),
      ),
    );
  }
}
