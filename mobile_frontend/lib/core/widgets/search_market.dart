import 'package:flutter/material.dart';

class SearchMarket extends StatefulWidget {
  const SearchMarket({super.key});

  @override
  State<SearchMarket> createState() => _SearchMarketState();
}

class _SearchMarketState extends State<SearchMarket> {
  final List<String> _items = [
    'Jacket',
    'Hoodie',
    'Jeans',
    'Dress',
    'Mango',
    'Blueberry',
    'Strawberry',
  ];
  String _query = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filteredItems = _items
        .where((item) => item.toLowerCase().contains(_query.toLowerCase()))
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
                  hintText: 'Search...',
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
            IconButton(
              icon: const Icon(
                Icons.filter_list,
                size: 30,
              ),
              onPressed: () {
                print('Filter Button Pressed');
              },
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
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]),
                    onTap: () {
                      _controller.text = filteredItems[index];
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
