import 'package:flutter/material.dart';
import 'package:ssr_parent_app/components/child_list_item.dart';

class RouteListItem extends StatelessWidget {
  final String name;

  const RouteListItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 10,),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
