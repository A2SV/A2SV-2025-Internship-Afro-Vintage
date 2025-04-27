import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardCard1 extends StatelessWidget {
  final int value;
  const DashboardCard1({super.key, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Active Bundles',
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
          SizedBox(height: 10),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 25),
          // Metrics Bar Chart for Analytics
          SizedBox(
            height: 46,
            child: _MetricsBarChart(),
          ),
        ],
      ),
    );
  }
}

class _MetricsBarChart extends StatelessWidget {
  const _MetricsBarChart();

  final List<double> _values = const [
    60, 90, 70, 40, 100, 80, 55, 75, 95, 65, 85, 50, 70, 60, 80, 90, 100, 60, 70, 80
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _values.map((value) {
        return Container(
          width: 4,
          height: value * 0.4,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: Colors.teal[700],
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }).toList(),
    );
  }
}
