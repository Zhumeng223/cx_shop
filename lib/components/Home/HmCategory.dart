import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const HmCategory({super.key, required this.categoryList});

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
          final item = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(item.picture ?? ""),
                Text(item.name ?? ""),
              ],
            ),
          );
        },
        itemCount: widget.categoryList.length,
      ),
    );
  }
}
