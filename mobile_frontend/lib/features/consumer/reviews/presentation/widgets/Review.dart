import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 130,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        "https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jack Santiago",
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: Color(0xFF8C8787), size: 18),
                            SizedBox(width: 5),
                            Text(
                              "13 sep, 2020",
                              style: TextStyle(
                                  color: Color(0xFF8C8787), fontSize: 14),
                            ),
                          ],
                        )
                      ])
                ],
              ),
              const Column(
                children: [
                  Row(
                    children: [
                      Text('4.8'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'rating',
                        style: TextStyle(color: Color(0xFF8F959E)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      Icon(Icons.star_border_rounded,
                          color: Colors.amber, size: 18),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            '''Lorem ipsum dolor sit amet, consectetur  hello adipiscing elit. Pellentesque malesuada eget vitae amet. 
Curabitur at lacus ac justo luctus posuere. Vivamus dignissim, tortor ut pulvinar efficitur, neque 
nisi porta ligula, nec laoreet nisi justo ac leo. Sed venenatis magna ut libero laoreet, nec 
volutpat sapien eleifend. Donec id lectus sit amet turpis dignissim rhoncus non non odio. Fusce 
vitae nulla a urna fermentum varius. Quisque vitae nunc eget erat aliquet pharetra non in ligula. 
Integer nec velit et purus cursus tristique. Suspendisse in risus nec purus tincidunt convallis.''',
            style: TextStyle(color: Color(0xFF8C8787), fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
