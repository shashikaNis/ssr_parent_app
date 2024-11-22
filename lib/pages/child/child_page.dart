import 'package:flutter/material.dart';
import 'package:ssr_parent_app/components/route_list_item.dart';

class ChildPage extends StatefulWidget {
  const ChildPage({super.key});

  @override
  State<ChildPage> createState() => ChildPageState();
}

class ChildPageState extends State<ChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/ssr_logo.png"),
                ),
                const Text("Child 01"),
                Container(
                  width: 300,
                  height: 200,
                  margin: const EdgeInsets.only(top: 10,),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Device Code"),
                        SizedBox(
                          height: 15,
                        ),
                        Text("SSR000123"),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("ADD ROUTE"),
                ),
                const RouteListItem(
                  name: "Route 01",
                ),
                 const RouteListItem(
                  name: "Route 02",
                ),
                const RouteListItem(
                  name: "Route 03",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
