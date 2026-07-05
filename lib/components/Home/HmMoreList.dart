import 'package:flutter/material.dart';

class HmMoreList extends StatefulWidget {
  const HmMoreList({super.key});

  @override
  State<HmMoreList> createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            "数据${index + 1}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      },
      itemCount: 100,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}
