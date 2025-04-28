import 'package:flutter/material.dart';
import '../../data/repositories/history_repository.dart';
import '../../data/models/history_order_model.dart';
import '../widgets/history_table.dart';
import '../../../../../../core/network/api_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryRepository _repository;
  List<HistoryOrderModel> _orders = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _repository = HistoryRepository(api: ApiService());
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    setState(() { _loading = true; _error = null; });
    try {
      final rawOrders = await _repository.fetchSupplierOrderHistory();
      setState(() {
        _orders = rawOrders.map((e) => HistoryOrderModel.fromJson(e)).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sold Bundles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Error: \\$_error'))
                : HistoryTable(orders: _orders),
      ),
    );
  }
} 