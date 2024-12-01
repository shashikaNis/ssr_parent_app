import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssr_parent_app/components/route_list_item.dart';
import 'package:go_router/go_router.dart';
import 'package:ssr_parent_app/service/child_service.dart';
import 'package:ssr_parent_app/service/route_service.dart';

class ChildPage extends StatefulWidget {
  final String childId;
  late RouteService routeService;

   ChildPage({super.key, required this.childId}){
    routeService = RouteService(childId);
  }

  @override
  State<ChildPage> createState() => ChildPageState();
}

class ChildPageState extends State<ChildPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Childs"),
        leading: IconButton(onPressed: (){
          context.go('/home');
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Center(
            child: FutureBuilder<DocumentSnapshot>(
                future: ChildService().getChild(widget.childId),
                builder: (context, snapshot) {

                  /// show loading indicator while data loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  /// show error message when data loading failed
                  else if (snapshot.hasError) {
                    return Center(child: Text('Error:${snapshot.error}'));
                  }
                  /// when data base not have requested child
                  else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(
                      child: Text('Child not found'),
                    );
                  }
                  /// finally if data available show the child
                  else {
                    final childDetails =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage("assets/images/ssr_logo.png"),
                          ),
                           Text(childDetails['name']),
                          Container(
                            width: 300,
                            height: 200,
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                            onPressed: () {
                              context.go("/route/${widget.childId}");
                            },
                            child: const Text("ADD ROUTE"),
                          ),
                          Expanded(child: StreamBuilder(stream:widget.routeService.getRoutes() , builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            final routes = snapshot.data!.docs;
                            return ListView.builder(
                                itemCount: routes.length,
                                itemBuilder: (context, index) {
                                  final route = routes[index];
                                  return RouteListItem(
                                    name: route['name'],
                                  );
                                });
                          })),

                        ],
                      ),
                    );
                  }
                })),
      ),
    );
  }
}
