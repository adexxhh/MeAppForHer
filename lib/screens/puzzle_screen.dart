import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  // 3x3 Puzzle state: list of 9 integers containing 0..8
  // 8 represents the empty tile.
  late List<int> _tiles;
  bool _isSolved = false;
  bool _showNumbers = false;
  bool _isPeeking = false;

  // The path to your custom image!
  final String _imageAsset = 'assets/us.jpg';

  @override
  void initState() {
    super.initState();
    _loadNewGame();
  }

  void _loadNewGame() {
    setState(() {
      _tiles = List.generate(9, (index) => index);
      _isSolved = false;
    });

    // Shuffle by making 150 random valid moves
    // This absolutely guarantees the puzzle is mathematically solvable
    _performShuffle();
  }

  void _performShuffle() {
    final random = Random();
    int emptyIndex = 8;
    
    for (int i = 0; i < 150; i++) {
      List<int> neighbors = _getValidNeighbors(emptyIndex);
      int moveTarget = neighbors[random.nextInt(neighbors.length)];
      
      // Swap
      _tiles[emptyIndex] = _tiles[moveTarget];
      _tiles[moveTarget] = 8;
      emptyIndex = moveTarget;
    }
    
    // Ensure we didn't accidentally perfectly solve it during shuffle
    if (_checkIfSolved()) {
      _performShuffle();
    }
  }

  List<int> _getValidNeighbors(int index) {
    List<int> neighbors = [];
    int row = index ~/ 3;
    int col = index % 3;

    if (row > 0) neighbors.add(index - 3); // Up
    if (row < 2) neighbors.add(index + 3); // Down
    if (col > 0) neighbors.add(index - 1); // Left
    if (col < 2) neighbors.add(index + 1); // Right
    return neighbors;
  }

  void _onTileTapped(int index) {
    if (_isSolved) return;

    int emptyIndex = _tiles.indexOf(8);
    List<int> validMoves = _getValidNeighbors(emptyIndex);

    if (validMoves.contains(index)) {
      setState(() {
        _tiles[emptyIndex] = _tiles[index];
        _tiles[index] = 8;
        
        if (_checkIfSolved()) {
          _isSolved = true;
        }
      });
    }
  }

  bool _checkIfSolved() {
    for (int i = 0; i < 9; i++) {
      if (_tiles[i] != i) return false;
    }
    return true;
  }

  Widget _buildPuzzleGrid() {
    if (_isPeeking) {
      return Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: AppTheme.starkBlack,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
        ),
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Image.asset(_imageAsset, fit: BoxFit.cover),
        ),
      ).animate().scale(curve: Curves.easeOutBack, duration: 300.ms);
    }

    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: AppTheme.starkBlack,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
      ),
      padding: const EdgeInsets.all(4), // Small bezel
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          int pieceValue = _tiles[index];
          
          if (pieceValue == 8) {
            // The empty tile
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }

          // Fractional alignment maps (0,0) to top-left and (1,1) to bottom-right
          double xOffset = (pieceValue % 3) / 2.0;
          double yOffset = (pieceValue ~/ 3) / 2.0;

          bool isLockedIn = pieceValue == index && pieceValue != 8;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTileTapped(index),
            onPanDown: (_) => _onTileTapped(index), // Grabs swipe/drag physical motions
            child: Container(
              decoration: isLockedIn && !_isSolved
                  ? BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 2),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 6)],
                    )
                  : null,
              child: LayoutBuilder(
              builder: (context, constraints) {
                return ClipRect(
                  child: OverflowBox(
                    maxWidth: constraints.maxWidth * 3.05, // 3.05 slightly corrects grid margins
                    maxHeight: constraints.maxHeight * 3.05,
                    alignment: FractionalOffset(xOffset, yOffset),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          _imageAsset,
                          fit: BoxFit.cover,
                          width: constraints.maxWidth * 3.05,
                          height: constraints.maxHeight * 3.05,
                        ),
                        if (_showNumbers && pieceValue != 8)
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                              child: Text(
                                "${pieceValue + 1}",
                                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
            ),
          );
        },
      ),
    ).animate().scale(curve: Curves.easeOutBack, duration: 600.ms);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Jigsaw Challenge 🎨",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: AppTheme.starkWhite),
                  ),
                ),
              ).animate().slideY(begin: -0.5).fadeIn(),
              
              const SizedBox(height: 40),
              
              _buildPuzzleGrid(),

              const SizedBox(height: 30),

              if (_isSolved)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "GOOD WORK, BUT ARE YOU BORED? TEXT HIM 📱",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.starkWhite, fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ).animate().scale(curve: Curves.elasticOut)
              else
                const Text(
                  "Slide the tiles to complete the picture!",
                  style: TextStyle(color: AppTheme.starkWhite, fontSize: 16, fontWeight: FontWeight.w600),
                ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   ElevatedButton.icon(
                      onPressed: () => setState(() => _showNumbers = !_showNumbers),
                      icon: Icon(_showNumbers ? Icons.visibility_off : Icons.visibility, size: 20),
                      label: Text(_showNumbers ? "Hide Numbers" : "Help Me!"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.starkWhite,
                        foregroundColor: AppTheme.starkBlack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                   ).animate().slideY(begin: 0.5),
                   
                   const SizedBox(width: 15),
                   
                   GestureDetector(
                      onTapDown: (_) => setState(() => _isPeeking = true),
                      onTapUp: (_) => setState(() => _isPeeking = false),
                      onTapCancel: () => setState(() => _isPeeking = false),
                      child: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                         decoration: BoxDecoration(
                           color: AppTheme.starkWhite, 
                           borderRadius: BorderRadius.circular(15)
                         ),
                         child: Row(
                           children: [
                             const Icon(Icons.image, color: AppTheme.starkBlack, size: 20), 
                             const SizedBox(width: 8), 
                             const Text("Hold to Peek", style: TextStyle(color: AppTheme.starkBlack, fontWeight: FontWeight.bold))
                           ]
                         ),
                      ),
                   ).animate().slideY(begin: 0.5),
                ],
              ),
              
              const SizedBox(height: 30),

              // Reset Button
              ElevatedButton.icon(
                onPressed: _loadNewGame,
                icon: const Icon(Icons.refresh_rounded, size: 28),
                label: const Text("Reshuffle Puzzle"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.starkBlack,
                  foregroundColor: AppTheme.starkWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ).animate().slideY(begin: 0.5),

              const SizedBox(height: 100), // Clearance for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}