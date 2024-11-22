import 'package:flutter/material.dart';
import 'package:ssr_parent_app/pages/home/home_page.dart';
import 'package:go_router/go_router.dart';
class ChildListItem extends StatelessWidget {
  final Color dotColors;
  final String name;

  const ChildListItem({super.key, required this.dotColors, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){context.go('/child');},
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: dotColors,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
