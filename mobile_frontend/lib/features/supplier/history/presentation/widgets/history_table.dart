import 'package:flutter/material.dart';
import '../../data/models/history_order_model.dart';

class HistoryTable extends StatelessWidget {
  final List<HistoryOrderModel> orders;
  const HistoryTable({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('SOLD ID')),
          DataColumn(label: Text('SOLD NUMBER')),
          DataColumn(label: Text('STATUS')),
          DataColumn(label: Text('CUSTOMER')),
        ],
        rows: orders.map((order) => DataRow(cells: [
          DataCell(Text(order.id)),
          DataCell(Text(order.bundleId)),
          DataCell(Text(order.status)),
          DataCell(Text(order.resellerUsername)),
        ])).toList(),
      ),
    );
  }
} 