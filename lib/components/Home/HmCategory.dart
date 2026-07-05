import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  const HmCategory({super.key});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            color: Colors.blue,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "分类",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
