import 'package:flutter/material.dart';
import 'dart:ui';
import '../../theme/app_theme.dart';

class EcdColoringScreen extends StatefulWidget {
  const EcdColoringScreen({super.key});

  @override
  State<EcdColoringScreen> createState() => _EcdColoringScreenState();
}

class _EcdColoringScreenState extends State<EcdColoringScreen> {
  final List<DrawingPoint?> _points = [];
  Color _selectedColor = Colors.red;
  final double _strokeWidth = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      appBar: AppBar(
        title: const Text('Coloring Book'),
        backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() => _points.clear()),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppTheme.surfaceDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorBox(Colors.red),
                _buildColorBox(Colors.green),
                _buildColorBox(Colors.blue),
                _buildColorBox(Colors.yellow),
                _buildColorBox(Colors.purple),
                _buildColorBox(Colors.orange),
                _buildColorBox(Colors.white),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _points.add(DrawingPoint(
                        point: details.localPosition,
                        paint: Paint()
                          ..color = _selectedColor
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = _strokeWidth
                          ..isAntiAlias = true,
                      ));
                    });
                  },
                  onPanStart: (details) {
                    setState(() {
                      _points.add(DrawingPoint(
                        point: details.localPosition,
                        paint: Paint()
                          ..color = _selectedColor
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = _strokeWidth
                          ..isAntiAlias = true,
                      ));
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      _points.add(null);
                    });
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(Icons.pets, size: 250, color: Colors.grey.withValues(alpha: 0.2)),
                      ),
                      CustomPaint(
                        painter: DrawingPainter(pointsList: _points),
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(Color color) {
    bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 8, offset: const Offset(0, 2))
          ],
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> pointsList;

  DrawingPainter({required this.pointsList});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i]!.point, pointsList[i + 1]!.point, pointsList[i]!.paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [pointsList[i]!.point], pointsList[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoint {
  Paint paint;
  Offset point;
  DrawingPoint({required this.point, required this.paint});
}
