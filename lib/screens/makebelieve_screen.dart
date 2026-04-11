import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../data/makebelieve_data.dart';

enum GameState { intro, history, chooseCity, chooseHisJob, chooseHerJob, reading, rating }

class MakebelieveScreen extends StatefulWidget {
  const MakebelieveScreen({Key? key}) : super(key: key);

  @override
  State<MakebelieveScreen> createState() => _MakebelieveScreenState();
}

class _MakebelieveScreenState extends State<MakebelieveScreen> {
  GameState _state = GameState.intro;

  // Active choices
  String _selectedCity = "";
  String _selectedHisJob = "";
  String _selectedHerJob = "";
  String _currentNarrative = "";

  // Options
  List<String> _cityOptions = [];
  List<String> _hisJobOptions = [];
  List<String> _herJobOptions = [];

  // History
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyStr = prefs.getString('makebelieve_history');
    if (historyStr != null) {
      final List<dynamic> decoded = json.decode(historyStr);
      setState(() {
        _history = decoded.map((e) => e as Map<String, dynamic>).toList().reversed.toList();
      });
    }
  }

  Future<void> _saveToHistory(int rating) async {
    final prefs = await SharedPreferences.getInstance();
    
    final newEntry = {
      'date': DateTime.now().toIso8601String(),
      'city': _selectedCity,
      'hisJob': _selectedHisJob,
      'herJob': _selectedHerJob,
      'story': _currentNarrative,
      'rating': rating,
    };

    final savedList = List<Map<String, dynamic>>.from(_history.reversed.toList());
    savedList.add(newEntry);
    
    await prefs.setString('makebelieve_history', json.encode(savedList));
    _loadHistory();
    
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _state = GameState.intro;
      _selectedCity = "";
      _selectedHisJob = "";
      _selectedHerJob = "";
      _currentNarrative = "";
    });
  }

  void _startGame() {
    setState(() {
      _cityOptions = MakebelieveData.getRandomCities(3);
      _hisJobOptions = MakebelieveData.getRandomOccupations(3);
      
      // Ensure her options don't overlap totally with his options visually
      var tempHer = MakebelieveData.getRandomOccupations(10);
      tempHer.removeWhere((e) => _hisJobOptions.contains(e));
      _herJobOptions = tempHer.take(3).toList();

      _state = GameState.chooseCity;
    });
  }

  void _generateStory() {
    _currentNarrative = MakebelieveData.generateNarrative(_selectedCity, _selectedHisJob, _selectedHerJob);
    setState(() {
      _state = GameState.reading;
    });
  }

  Widget _buildIntro() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_awesome, color: AppTheme.starkBlack, size: 60)
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 2.seconds),
          const SizedBox(height: 20),
          const Text(
            "Baby,\nMakebelieve Time!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: AppTheme.starkBlack, height: 1.1),
          ).animate().slideY(begin: -0.2).fadeIn(),
          const SizedBox(height: 20),
          const Text(
            "Build our dream timeline, one choice at a time.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.starkBlack),
          ),
          const SizedBox(height: 40),
          
          ElevatedButton(
            onPressed: _startGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.starkBlack,
              foregroundColor: AppTheme.starkWhite,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text("Dream a Life \u2728", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ).animate().scale(delay: 400.ms, curve: Curves.elasticOut),

          const SizedBox(height: 20),

          if (_history.isNotEmpty)
            TextButton(
              onPressed: () => setState(() => _state = GameState.history),
              child: const Text("Read our Diary", style: TextStyle(color: AppTheme.starkBlack, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
            ).animate().fadeIn(delay: 800.ms),
        ],
      ),
    );
  }

  Widget _buildHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Our Timelines \uD83D\uDCD6",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.starkBlack),
            ),
            IconButton(icon: const Icon(Icons.close, size: 30), onPressed: () => setState(() => _state = GameState.intro)),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _history.length,
            itemBuilder: (context, index) {
              final item = _history[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.starkWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.starkBlack, width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(item['city'] ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.starkBlack)),
                        ),
                        Row(
                          children: List.generate(5, (starIdx) => Icon(
                            starIdx < (item['rating'] as int) ? Icons.star : Icons.star_border,
                            color: Colors.amber, size: 20,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("Adesh: ${item['hisJob']}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                    Text("Khadija: ${item['herJob']}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                    const SizedBox(height: 15),
                    Text(
                      item['story'] ?? "",
                      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: AppTheme.starkBlack),
                    ),
                  ],
                ),
              ).animate().slideX(begin: 1.0, delay: (index * 100).ms);
            },
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildChooseCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Text(
          "Step 1:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Where do we live?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.starkBlack),
            ),
            IconButton(
              icon: const Icon(Icons.shuffle_rounded, size: 28),
              onPressed: () {
                setState(() => _cityOptions = MakebelieveData.getRandomCities(3));
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _cityOptions.length,
            itemBuilder: (context, index) {
              final city = _cityOptions[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCity = city;
                    _state = GameState.chooseHisJob;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.starkBlack, width: 3),
                    boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 10)],
                    image: DecorationImage(
                      image: NetworkImage(MakebelieveData.getCityImageUrl(city)),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    city,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 10)]),
                  ),
                ).animate().slideY(begin: 0.5, delay: (index * 150).ms).fadeIn(),
              );
            },
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildJobSelection(String title, List<String> options, Function(String) onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          title == "Adesh" ? "Step 2:" : "Step 3:",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "What is $title doing?",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.starkBlack),
            ),
            IconButton(
              icon: const Icon(Icons.shuffle_rounded, size: 28),
              onPressed: () {
                setState(() {
                   if (title == "Adesh") {
                     _hisJobOptions = MakebelieveData.getRandomOccupations(3);
                   } else {
                     var tempHer = MakebelieveData.getRandomOccupations(10);
                     tempHer.removeWhere((e) => _hisJobOptions.contains(e));
                     _herJobOptions = tempHer.take(3).toList();
                   }
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: Column(
            children: options.asMap().entries.map((entry) {
              int idx = entry.key;
              String job = entry.value;
              return GestureDetector(
                onTap: () => onSelected(job),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: BoxDecoration(
                    color: title == "Adesh" ? AppTheme.babyBlue : AppTheme.bubblegumPink,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.starkBlack, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(2, 4), blurRadius: 0)],
                  ),
                  child: Text(
                    job,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.starkBlack),
                  ),
                ).animate().scale(delay: (idx * 150).ms, curve: Curves.easeOutBack),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReading() {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text("Our Future", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.starkBlack)),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppTheme.starkBlack,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: AppTheme.pastelYellow.withOpacity(0.5), blurRadius: 30, spreadRadius: 10)],
              ),
              child: Text(
                _currentNarrative,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppTheme.starkWhite,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ).animate().fadeIn(duration: 1.seconds),
        ElevatedButton(
          onPressed: () => setState(() => _state = GameState.rating),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.starkBlack,
            foregroundColor: AppTheme.starkWhite,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text("Rate This Timeline \u2728", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ).animate().scale(delay: 2.seconds, curve: Curves.elasticOut),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildRating() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppTheme.starkWhite,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppTheme.starkBlack, width: 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "How was this timeline?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.starkBlack),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => _saveToHistory(index + 1),
                  child: Icon(Icons.star_rounded, size: 50, color: Colors.amber)
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), delay: (index * 100).ms),
                );
              }),
            ),
            const SizedBox(height: 20),
            const Text("Tap a star to save to your Diary!", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ],
        ),
      ).animate().scale(curve: Curves.elasticOut, duration: 800.ms),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeContent;
    switch (_state) {
      case GameState.intro:
        activeContent = _buildIntro();
        break;
      case GameState.history:
        activeContent = _buildHistory();
        break;
      case GameState.chooseCity:
        activeContent = _buildChooseCity();
        break;
      case GameState.chooseHisJob:
        activeContent = _buildJobSelection("Adesh", _hisJobOptions, (job) {
          setState(() {
            _selectedHisJob = job;
            _state = GameState.chooseHerJob;
          });
        });
        break;
      case GameState.chooseHerJob:
        activeContent = _buildJobSelection("Khadija", _herJobOptions, (job) {
          setState(() {
            _selectedHerJob = job;
            _generateStory();
          });
        });
        break;
      case GameState.reading:
        activeContent = _buildReading();
        break;
      case GameState.rating:
        activeContent = _buildRating();
        break;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(animation),
                child: child,
              ),
            );
          },
          child: KeyedSubtree(
            key: ValueKey<GameState>(_state),
            child: activeContent,
          ),
        ),
      ),
    );
  }
}
