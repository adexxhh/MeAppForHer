import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../theme/app_theme.dart';

class Stroke {
  final List<Offset> points;
  final Color color;
  final double width;

  Stroke({
    required this.points,
    required this.color,
    required this.width,
  });
}

class DrawPainter extends CustomPainter {
  final List<Stroke> strokes;
  
  DrawPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    for (var stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.width
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
        
      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawScreen extends StatefulWidget {
  const DrawScreen({Key? key}) : super(key: key);

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  List<Stroke> strokes = [];
  Stroke? currentStroke;
  
  Color selectedColor = AppTheme.starkBlack;
  double strokeWidth = 5.0;
  bool isEraser = false;
  
  final GlobalKey _repaintKey = GlobalKey();

  final List<Color> colors = [
    AppTheme.starkBlack,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.amber,
  ];

  void _onPanStart(DragStartDetails details) {
    RenderBox? box = _repaintKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    
    Offset point = box.globalToLocal(details.globalPosition);
    setState(() {
      currentStroke = Stroke(
        points: [point],
        color: isEraser ? AppTheme.starkWhite : selectedColor,
        width: isEraser ? 30.0 : strokeWidth,
      );
      strokes.add(currentStroke!);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    RenderBox? box = _repaintKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || currentStroke == null) return;

    Offset point = box.globalToLocal(details.globalPosition);
    setState(() {
      currentStroke!.points.add(point);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    currentStroke = null;
  }

  void _clearCanvas() {
    setState(() {
      strokes.clear();
    });
  }

  Future<void> _shareDrawing() async {
    try {
      RenderRepaintBoundary boundary =
          _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/our_masterpiece.png').create();
        await file.writeAsBytes(pngBytes);
        
        await Share.shareXFiles(
          [XFile(file.path)],
          text: "look baby look, this is what i made on our app \uD83C\uDFA8\u2728",
        );
      }
    } catch (e) {
      debugPrint("Error sharing image: $e");
    }
  }

  Widget _buildToolbar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: AppTheme.starkBlack,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Colors
          ...colors.map((color) => GestureDetector(
            onTap: () => setState(() {
              selectedColor = color;
              isEraser = false;
            }),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: (!isEraser && selectedColor == color) ? Colors.white : Colors.transparent,
                  width: 3,
                ),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
            ).animate(target: (!isEraser && selectedColor == color) ? 1 : 0).scale(end: const Offset(1.2, 1.2)),
          )).toList(),
          
          // Eraser
          GestureDetector(
            onTap: () => setState(() => isEraser = true),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isEraser ? AppTheme.pastelYellow : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.format_paint_outlined, color: isEraser ? AppTheme.starkBlack : Colors.white),
            ),
          ),
          
          // Clear
          IconButton(
            onPressed: _clearCanvas,
            icon: const Icon(Icons.delete_outline, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Draw for Me",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                ).animate().slideY(begin: -0.5).fadeIn(),
                
                ElevatedButton.icon(
                  onPressed: _shareDrawing,
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: const Text("Share"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.pastelYellow,
                    foregroundColor: AppTheme.starkBlack,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ).animate().scale(delay: 500.ms, curve: Curves.elasticOut),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          _buildToolbar().animate().fadeIn(delay: 300.ms).slideY(begin: -0.2),

          const SizedBox(height: 20),

          // Core Canvas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: RepaintBoundary(
                  key: _repaintKey,
                  child: GestureDetector(
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppTheme.starkWhite,
                      ),
                      child: CustomPaint(
                        painter: DrawPainter(strokes),
                      ),
                    ),
                  ),
                ),
              ),
            ).animate().scale(curve: Curves.easeOutBack, delay: 100.ms),
          ),
          
          const SizedBox(height: 100), // padding for global nav bar
        ],
      ),
    );
  }
}
