import 'package:flutter/material.dart';

class SearchMarket extends StatefulWidget {
  final List<dynamic> products; // Accept products as input

  const SearchMarket({super.key, required this.products});

  @override
  State<SearchMarket> createState() => _SearchMarketState();
}

class _SearchMarketState extends State<SearchMarket> {
  String _query = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Filter products based on the search query
    final filteredProducts = widget.products
        .where((product) =>
            product.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (val) {
                  setState(() {
                    _query = val;
                  });
                },
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF008080).withOpacity(0.17),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.tune, // Filter icon
                color: Color(0xFF5C5F6A),
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_query.isNotEmpty)
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ListTile(
                    title: Text(product.title), // Display product name
                    onTap: () {
                      _controller.text = product.title;
                      setState(() => _query = '');
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
