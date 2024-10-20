// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty


import 'package:flutter/material.dart';
import 'package:todoapp/core/shared_widget/divider.dart';
import 'package:todoapp/core/shared_widget/task_item_widget.dart';
import 'package:todoapp/logic/app_logic.dart';

class ArchivedScreen extends StatefulWidget {
  const ArchivedScreen({super.key});

  @override
  State<ArchivedScreen> createState() => _ArchivedScreenState();
}

class _ArchivedScreenState extends State<ArchivedScreen> {
  @override
  Widget build(BuildContext context) {

    return 
       ListView.separated(
        
            physics: BouncingScrollPhysics(),
            


            separatorBuilder: (context, index) => MyDivider(),
            itemBuilder: (context, index) =>
                BuildTaskItem(task: AppLogic.archivedTasks[index],),
            itemCount: AppLogic.archivedTasks.length);
        
  }
}
