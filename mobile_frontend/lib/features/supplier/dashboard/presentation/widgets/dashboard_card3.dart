import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardCard3 extends StatelessWidget {
  final int totalBundlesListed;
  final int activeCount;
  final int soldCount;
  const DashboardCard3({super.key, required this.totalBundlesListed, required this.activeCount, required this.soldCount});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make the card fill the available width
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
              Flexible(
                child: Text(
                  'Performance Metrics',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(
            'Listed: $totalBundlesListed, Active: $activeCount, Sold: $soldCount',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Color(0xFF5C5F6A),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: 10),
          Text(
            soldCount.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: CustomPaint(
              painter: _LineChartPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> points = [
    40, 120, 30, 110, 80, 100, 90, 70, 100, 60, 110, 80, 60, 90, 40, 120, 30, 110, 80, 100
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00796B)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = i * (size.width / (points.length - 1));
      final y = size.height - (points[i] / 130 * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
