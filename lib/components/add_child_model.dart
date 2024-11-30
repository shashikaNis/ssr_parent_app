import 'package:flutter/material.dart';
import 'package:ssr_parent_app/service/child_service.dart';

class AddChildModel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddChildModelState();
}

class _AddChildModelState extends State<AddChildModel> {
  TextEditingController childNameController = TextEditingController();
  ChildService _childService = ChildService();
  onclickAddChild() async{
    await _childService.addChild(childNameController.text);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Child"),
      content: TextFormField(
        controller: childNameController,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: onclickAddChild,
          child: Text("Add Child"),
        )
      ],
    );
  }
}
