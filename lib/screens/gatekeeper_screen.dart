import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'main_base.dart';

class GatekeeperScreen extends StatefulWidget {
  const GatekeeperScreen({Key? key}) : super(key: key);

  @override
  State<GatekeeperScreen> createState() => _GatekeeperScreenState();
}

class _GatekeeperScreenState extends State<GatekeeperScreen> {
  int currentStep = 1;

  // Step 1 State
  final TextEditingController _nicknameController = TextEditingController();
  final List<String> nicknameErrors = [
    "You're not my girl, whose girl are you?",
    "Slytherin spotted in Gryffindor!",
    "Let it go, imposter! (Hans, is that you?)",
    "Access denied. The cold never bothered me anyway, but this login attempt does."
  ];

  // Step 2 State
  final List<String> sentenceErrors = [
    "Grammar check! Try again.",
    "Did Olaf scramble these words?",
    "Not quite right. Try rearranging!"
  ];
  
  final List<String> availableWords = ["boy", "I", "love", "him"];
  List<String> droppedWords = [];
  
  String currentError = "";

  // Animation controllers via simple bool toggles
  bool _shakeInput = false;
  bool _shakeDropZone = false;

  void _verifyNickname() async {
    final input = _nicknameController.text.trim().toLowerCase();
    if (input == "tingi" || input == "baby") {
      setState(() {
        currentError = "";
        currentStep = 2;
      });
    } else {
      setState(() {
        currentError = nicknameErrors[Random().nextInt(nicknameErrors.length)];
        _shakeInput = !_shakeInput; // trigger shake
      });
    }
  }

  void _verifyPuzzle() async {
    final formedSentence = droppedWords.join(" ");
    if (formedSentence == "boy I love him" || formedSentence == "I love him boy") {
      setState(() {
        currentError = "";
      });
      // Navigate to Home Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainBase()),
      );
    } else {
      setState(() {
        currentError = sentenceErrors[Random().nextInt(sentenceErrors.length)];
        _shakeDropZone = !_shakeDropZone; // trigger shake
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Blobs
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: AppTheme.pastelYellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: AppTheme.bubblegumPink,
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: currentStep == 1 ? _buildStep1() : _buildStep2(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Halt!",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: AppTheme.starkBlack,
          ),
        ),
        const SizedBox(height: 40),
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: const BoxDecoration(
            color: AppTheme.sageGreen,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: TextField(
            controller: _nicknameController,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.starkBlack,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Who goes there? (Enter your secret nickname)",
              hintStyle: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
            ),
            onSubmitted: (_) => _verifyNickname(),
          ),
        ).animate(key: ValueKey(_shakeInput))
         .shakeX(hz: 8, amount: 5, duration: 300.ms),

        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _verifyNickname,
          child: const Text("Next"),
        ),
        
        if (currentError.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(
            currentError,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ).animate().slideY(begin: 0.5, curve: Curves.easeOut).fadeIn(),
        ],
      ],
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildStep2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Prove it.",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppTheme.starkBlack,
          ),
        ),
        const Text(
          "How do you feel about me?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.starkBlack,
          ),
        ),
        const SizedBox(height: 40),
        
        // Word Bank
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: availableWords.map((word) {
            final isDropped = droppedWords.contains(word);
            return Draggable<String>(
              data: word,
              feedback: _buildWordChip(word, isDragging: true),
              childWhenDragging: Opacity(
                opacity: 0.3,
                child: _buildWordChip(word),
              ),
              child: isDropped ? const SizedBox.shrink() : _buildWordChip(word),
            );
          }).toList(),
        ),

        const SizedBox(height: 40),

        // Drop Zone
        DragTarget<String>(
          onAcceptWithDetails: (details) {
            setState(() {
              if (!droppedWords.contains(details.data)) {
                droppedWords.add(details.data);
              }
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              constraints: const BoxConstraints(minHeight: 80),
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: candidateData.isNotEmpty 
                    ? AppTheme.babyBlue.withOpacity(0.5) 
                    : AppTheme.babyBlue.withOpacity(0.2),
                border: Border.all(
                  color: AppTheme.starkBlack,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: droppedWords.map((word) => GestureDetector(
                  onTap: () {
                    setState(() {
                      droppedWords.remove(word);
                    });
                  },
                  child: _buildWordChip(word),
                )).toList(),
              ),
            );
          },
        ).animate(key: ValueKey(_shakeDropZone))
         .shakeX(hz: 8, amount: 5, duration: 300.ms),

        const SizedBox(height: 20),

        if (currentError.isNotEmpty)
          Text(
            currentError,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ).animate().slideY(begin: 0.5, curve: Curves.easeOut).fadeIn(),

        const SizedBox(height: 30),
        
        if (droppedWords.length == availableWords.length)
          ElevatedButton(
            onPressed: () {
              final formedSentence = droppedWords.join(" ");
              if (formedSentence == "boy I love him" || formedSentence == "I love him boy") {
                _verifyPuzzle();
              } else {
                _verifyPuzzle(); // this triggers error
              }
            },
            child: const Text("Verify"),
          ).animate().scale(delay: 200.ms).shimmer(duration: 1.seconds, delay: 500.ms),
      ],
    ).animate().fadeIn().slideX(begin: 0.1);
  }

  Widget _buildWordChip(String word, {bool isDragging = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.bubblegumPink,
        boxShadow: isDragging ? [
          const BoxShadow(
            color: Colors.black26, 
            blurRadius: 10, 
            offset: Offset(0, 5)
          )
        ] : [
          const BoxShadow(
            color: AppTheme.starkBlack,
            offset: Offset(2, 2),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
        border: Border.all(color: AppTheme.starkBlack, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: Text(
          word,
          style: const TextStyle(
            color: AppTheme.starkBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
