import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardCard2 extends StatelessWidget {
  final int? value;
  const DashboardCard2({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Best Selling',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(
            'THIS MONTH',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Color(0xFF5C5F6A),
            ),
          ),
          SizedBox(height: 30),
          // Custom Donut Chart with price in the center
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(120, 120),
                  painter: _DonutChartPainter(),
                ),
                Center(
                  child: Text(
                    value?.toString() ?? '-',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF23262F),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Update the donut painter for a more modern look
class _DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<double> segments = [0.35, 0.25, 0.20, 0.20];
    final List<Color> colors = [
      Color(0xFF009688),
      Color(0xFF4DB6AC),
      Color(0xFFB2DFDB),
      Color(0xFFE0F2F1),
    ];
    final double strokeWidth = 16;
    final double gap = 0.08; // gap in radians
    double startAngle = -1.57; // Start at top
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    for (int i = 0; i < segments.length; i++) {
      final sweepAngle = segments[i] * 6.28319 - gap;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        rect.deflate(strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
